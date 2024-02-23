//
//  PremiumContainer.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 31.01.24.

import Foundation
import Factory

// See: https://hmlongco.github.io/Factory/documentation/factory/containers
public final class UnderwritingContainer: SharedContainer {
    public static let shared = UnderwritingContainer()
    public let manager = ContainerManager()
}

extension UnderwritingContainer {
    // Config
    var contractConfig: Factory<Configuration.Contract> {
        self { Configuration.Contract() }
            .singleton
    }
    
    // Datasources
    var exchangeRateRemoteDataSource: Factory<ExchangeRateRemoteDatasource> {
        self { ExchangeRateRemoteDatasourceImpl(restClient: CoreContainer.shared.restClient())}
    }
    
    var premiumRemoteDatasource: Factory<PremiumRemoteDatasource> {
        self { PremiumRemoteDatasourceImpl(
            client: CoreContainer.shared.ethereumHttpClient(),
            contractConfig: self.contractConfig()
        )}
    }
    
    // Repositories
    var exchangeRateRepository: Factory<ExchangeRateRepository> {
        self { ExchangeRateRepositoryImpl(remoteDatasource: self.exchangeRateRemoteDataSource()) }
    }
    
    var premiumRepository: Factory<PremiumRepository> {
        self {
            PremiumRepositoryImpl(
                premiumRemoteDatasource: self.premiumRemoteDatasource(),
                walletLocalDatasource: OnboardingContainer.shared.walletLocalDataSource()
            )
        }
    }
    
    // Usecases
    var calculateBMI: Factory<CalculateBMI> {
        self { CalculateBMIUseCase() }
    }
    
    var checkBMI: Factory<CheckBMI> {
        self {
            CheckBMIUseCase(premiumRepository: self.premiumRepository())
        }
    }
    
    var calculateEthInEur: Factory<CalculateEthInEur> {
        self {
            CalculateEthInEurUseCase(
                exchangeRateRepository: self.exchangeRateRepository()
            )
        }
    }
    
    var calculateEurInEth: Factory<CalculateEurInEth> {
        self { CalculateEurInEthUseCase(
            exchangeRateRepository: self.exchangeRateRepository()
        ) }
    }
    
    var checkHealthQuestionValidity: Factory<CheckHealthQuestionValidity> {
        self { CheckHealthQuestionValidityUseCase(
            premiumRepository: self.premiumRepository()
        ) }
    }
    
    var calculatePremium: Factory<CalculateYearlyPremium> {
        self {
            CalculatePremiumUseCase(
                premiumRepository: self.premiumRepository(),
                calculateEthInEur: self.calculateEthInEur()
            )
        }
    }
    
    var underwriteContract: Factory<UnderwriteContract> {
        self { UnderwriteContractUseCase(
            contractRepository: ContractContainer.shared.contractRepository()
        ) }
    }

    var getContractByTransaction: Factory<GetContractByTransaction> {
        self { GetContractByTransactionUseCase(
            getValidContract: ContractContainer.shared.getValidContrat(),
            getTransactionState: CoreContainer.shared.getTransactionState()
        ) }
    }
}

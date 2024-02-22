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
    
    var insuranceContractRemoteDatasource: Factory<ContractRemoteDatasource> {
        self { ContractRemoteDatasourceImpl(
            client: CoreContainer.shared.ethereumHttpClient(),
            contractConfig: self.contractConfig()
        )}
    }
    
    // Repositories
    var exchangeRateRepository: Factory<ExchangeRateRepository> {
        self { ExchangeRateRepositoryImpl(remoteDatasource: self.exchangeRateRemoteDataSource()) }
    }
    
    var contractRepository: Factory<ContractRepository> {
        self {
            ContractRepositoryImpl(
                contractRemoteDatasource: self.insuranceContractRemoteDatasource(),
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
            CheckBMIUseCase(contractRepository: self.contractRepository())
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
            insuranceRepository: self.contractRepository()
        ) }
    }
    
    var calculatePremium: Factory<CalculateYearlyPremium> {
        self {
            CalculatePremiumUseCase(
                contractRepository: self.contractRepository(),
                calculateEthInEur: self.calculateEthInEur()
            )
        }
    }
    
    var underwriteContract: Factory<UnderwriteContract> {
        self { UnderwriteContractUseCase(
            contractRepository: self.contractRepository()
        ) }
    }
    
    var getValidContrat: Factory<GetValidContract> {
        self { GetValidContractUseCase(
            contractRepository: self.contractRepository()
        ) }
    }
    
    var getContractByTransaction: Factory<GetContractByTransaction> {
        self { GetContractByTransactionUseCase(
            getContract: self.getValidContrat(),
            getTransactionState: CoreContainer.shared.getTransactionState()
        ) }
    }
}

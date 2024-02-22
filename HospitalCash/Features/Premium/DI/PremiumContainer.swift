//
//  PremiumContainer.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 31.01.24.

import Foundation
import Factory

// See: https://hmlongco.github.io/Factory/documentation/factory/containers
public final class PremiumContainer: SharedContainer {
    public static let shared = PremiumContainer()
    public let manager = ContainerManager()
}

extension PremiumContainer {
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
        self { InsuranceContractRemoteDatasourceImpl(
            client: CoreContainer.shared.ethereumHttpClient(),
            contractConfig: self.contractConfig()
        )}
    }
    
    // Repositories
    var exchangeRateRepository: Factory<ExchangeRateRepository> {
        self { ExchangeRateRepositoryImpl(remoteDatasource: self.exchangeRateRemoteDataSource()) }
    }
    
    var insuraneRepository: Factory<ContractRepository> {
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
            CheckBMIUseCase(insuranceRepository: self.insuraneRepository())
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
            insuranceRepository: self.insuraneRepository()
        ) }
    }
    
    var calculatePremium: Factory<CalculateYearlyPremium> {
        self {
            CalculatePremiumUseCase(
                insuranceRepository: self.insuraneRepository(),
                calculateEthInEur: self.calculateEthInEur()
            )
        }
    }
    
    var underwriteContract: Factory<UnderwriteContract> {
        self { UnderwriteContractUseCase(
            insuranceRepository: self.insuraneRepository()
        ) }
    }
    
    var getContrat: Factory<GetContract> {
        self { GetContractUseCase(
            insuranceRepository: self.insuraneRepository()
        ) }
    }
    
    var getContractByTransaction: Factory<GetContractByTransaction> {
        self { GetContractByTransactionUseCase(
            getContract: self.getContrat(),
            getTransactionState: CoreContainer.shared.getTransactionState()
        ) }
    }
}

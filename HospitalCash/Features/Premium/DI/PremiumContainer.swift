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
    var contractConfig: Factory<Configuration.InsuranceContract> {
        self { Configuration.InsuranceContract() }
            .singleton
    }
    
    var walletConfig: Factory<Configuration.Wallet> {
        self { Configuration.Wallet() }
            .singleton
    }
    
    // Datasources
    var exchangeRateRemoteDataSource: Factory<ExchangeRateRemoteDatasource> {
        self { ExchangeRateRemoteDatasourceImpl(restClient: CoreContainer.shared.restClient())}
    }
    
    var walletLocalDataSource: Factory<WalletLocalDataSource> {
        self { WalletLocalDataSourceImpl(walletConfig: self.walletConfig() )}
    }
    
    var insuranceContractRemoteDatasource: Factory<InsuranceContractRemoteDatasource> {
        self { InsuranceContractRemoteDatasourceImpl(contractConfig: self.contractConfig() )}
    }
    
    // Repositories
    var exchangeRateRepository: Factory<ExchangeRateRepository> {
        self { ExchangeRateRepositoryImpl(remoteDatasource: self.exchangeRateRemoteDataSource()) }
    }
    
    var insuraneRepository: Factory<InsuranceRepository> {
        self {
            InsuranceRepositoryImpl(
                insuracenContractRemoteDatasource: self.insuranceContractRemoteDatasource()
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
}

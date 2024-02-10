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
    // Datasources
    var exchangeRateRemoteDataSource: Factory<ExchangeRateRemoteDatasource> {
        self { ExchangeRateRemoteDatasourceImpl(restClient: CoreContainer.shared.restClient())}
    }
    
    var walletLocalDataSource: Factory<WalletLocalDataSource> {
        self { WalletLocalDataSourceImpl()}
    }
    
    var insuranceContractRemoteDatasource: Factory<InsuranceContractRemoteDatasource> {
        self { InsuranceContractRemoteDatasourceImpl()}
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
    
    var calculateEthInEur: Factory<CalculateEthInEur> {
        self { CalculateEthInEurUseCase(
            exchangeRateRepository: self.exchangeRateRepository()
        ) }
    }
    
    var calculateEurInEth: Factory<CalculateEurInEth> {
        self { CalculateEurInEthUseCase(
            exchangeRateRepository: self.exchangeRateRepository()
        ) }
    }
    
    var checkHealthQuestionValidity: Factory<CheckHealthQuestionValidity> {
        self { CheckHealthQuestionValidityUseCase() }
    }
    
    var calculatePremium: Factory<CalculatePremium> {
        self {
            CalculatePremiumUseCase(insuranceRepository: self.insuraneRepository())
        }
    }
}

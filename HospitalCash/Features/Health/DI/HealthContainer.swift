//
//  HealthContainer.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import Foundation
import Factory
import HealthKit

public final class HealthContainer: SharedContainer {
    public static let shared = HealthContainer()
    public let manager = ContainerManager()
}

extension HealthContainer {
    // Clients
    var hkHealthStore: Factory<HKHealthStore> {
        self { HKHealthStore() }
            .singleton
    }
    
    // Config
    var healthConfig: Factory<Configuration.Health> {
        self { Configuration.Health() }
            .singleton
    }
    
    // Datasources
    var hkLocalDatasource: Factory<HKLocalDatasource> {
        self {
            HKLocalDataSourceImpl(
                healthStore: self.hkHealthStore()
            )
        }
    }
    var healthRemoteDatasource: Factory<HealthRemoteDatasource> {
        self {
            HealthRemoteDatasourceImpl(
                client: CoreContainer.shared.ethereumHttpClient(),
                contractConfig: ContractContainer.shared.contractConfig()
            )
        }
    }
    
    // Repositories
    var healthRepository: Factory<HealthRepository> {
        self {
            HealthRepositoryImpl(
                hkLocalDatasource: self.hkLocalDatasource(),
                healthRemoteDatasource: self.healthRemoteDatasource(),
                walletLocalDatasource: OnboardingContainer.shared.walletLocalDataSource()
            )
        }
    }
    
    // Usecases
    var getTodayStepCount: Factory<GetTodayStepCount> {
        self { GetTodayStepCountUseCase(
            healthRepository: self.healthRepository()
        ) }
    }
    
    var getWeeklyStepCount: Factory<GetWeeklyStepCount> {
        self { GetWeeklyStepCountUseCase(
            healthRepository: self.healthRepository(),
            healthConfig: self.healthConfig()
        ) }
    }
    
    var claimDiscount: Factory<ClaimDiscount> {
        self { CleaimDiscountUseCase(
            healthRepository: self.healthRepository(),
            getWeeklyStepcount: self.getWeeklyStepCount(),
            healthConfig: self.healthConfig()
        ) }
    }
    
}

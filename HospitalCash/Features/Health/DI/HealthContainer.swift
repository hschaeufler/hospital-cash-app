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
    
    // Datasources
    var hkLocalDatasource: Factory<HKLocalDatasource> {
        self {
            HKLocalDataSourceImpl(
                healthStore: self.hkHealthStore()
            )
        }
    }
    
    // Repositories
    var healthRepository: Factory<HealthRepository> {
        self {
            HealthRepositoryImpl(hkLocalDatasource: self.hkLocalDatasource())
        }
    }
    
    // Usecases
    var getTodayStepCount: Factory<GetTodayStepCount> {
        self { GetTodayStepCountUseCase(
            healthRepository: self.healthRepository()
        ) }
    }
    
}

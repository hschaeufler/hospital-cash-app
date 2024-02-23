//
//  HealthRepositoryImpl.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import Foundation
import HealthKit

class HealthRepositoryImpl: HealthRepository {
    let hkLocalDatasource: HKLocalDatasource
    
    init(
        hkLocalDatasource: HKLocalDatasource
    ) {
        self.hkLocalDatasource = hkLocalDatasource
    }

    func getTodayStepCount() async throws -> Double? {
       try await hkLocalDatasource.readTodaysSteps().sumQuantity()?.doubleValue(for: HKUnit.count())
    }
    
    func getWeeklySteps() async throws -> Double? {
       return nil
    }
}

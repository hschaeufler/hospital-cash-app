//
//  HKStatisticsModel.swift
//  HospitalCash
//
//  Created by hschaeufler on 23.02.24.
//

import Foundation
import HealthKit

extension HKStatistics {
    func toStepDateCountEntity() -> StepDateCountEntity {
        StepDateCountEntity(
            steps: self.sumQuantity()!.doubleValue(for: HKUnit.count()),
            date: self.startDate
        )
    }
}

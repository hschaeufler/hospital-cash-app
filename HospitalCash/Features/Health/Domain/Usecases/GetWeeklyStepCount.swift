//
//  GetWeeklyStepCount.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import Foundation

protocol GetWeeklyStepCount {
    func callAsFunction() async throws -> [StepDateCountEntity]
}

struct GetWeeklyStepCountUseCase: GetWeeklyStepCount {
    private let healthRepository: HealthRepository
    private let healthConfig: Configuration.Health
    
    init(
        healthRepository: HealthRepository,
        healthConfig: Configuration.Health
    ) {
        self.healthRepository = healthRepository
        self.healthConfig = healthConfig
    }
    
    func callAsFunction() async throws -> [StepDateCountEntity] {
        let lastPayoutDate = try await healthRepository.getLastPayoutDate()
        let weeklySteps = try await healthRepository.getWeeklySteps()
        return weeklySteps.map { stepDateCountEntity in
            var copy = stepDateCountEntity
            copy.isSubmitted = stepDateCountEntity.date < lastPayoutDate
                && stepDateCountEntity.steps >= Double(healthConfig.stepLimit)
            return copy
        }
    }
}

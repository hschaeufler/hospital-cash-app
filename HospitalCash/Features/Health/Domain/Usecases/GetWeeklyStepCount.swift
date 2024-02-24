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
    
    init(healthRepository: HealthRepository) {
        self.healthRepository = healthRepository
    }
    
    func callAsFunction() async throws -> [StepDateCountEntity] {
        let lastPayoutDate = try await healthRepository.getLastPayoutDate()
        let weeklySteps = try await healthRepository.getWeeklySteps()
        return weeklySteps.map { stepDateCountEntity in
            var copy = stepDateCountEntity
            copy.isSubmitted = stepDateCountEntity.date < lastPayoutDate
            return copy
        }
    }
}

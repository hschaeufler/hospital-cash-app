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
        return try await healthRepository.getWeeklySteps()
    }
}

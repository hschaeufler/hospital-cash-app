//
//  GetTodayStepCount.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import Foundation

protocol GetTodayStepCount {
    func callAsFunction() async throws -> Double?
}

struct GetTodayStepCountUseCase: GetTodayStepCount {
    private let healthRepository: HealthRepository
    
    init(healthRepository: HealthRepository) {
        self.healthRepository = healthRepository
    }
    
    func callAsFunction() async throws -> Double? {
        return try await healthRepository.getTodayStepCount()
    }
}

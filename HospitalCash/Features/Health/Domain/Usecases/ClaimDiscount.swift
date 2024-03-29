//
//  CleaimDiscount.swift
//  HospitalCash
//
//  Created by hschaeufler on 24.02.24.
//

import Foundation

protocol ClaimDiscount {
    func callAsFunction() async throws -> String
}

struct CleaimDiscountUseCase: ClaimDiscount {
    private let healthRepository: HealthRepository
    private let getWeeklyStepcount: GetWeeklyStepCount
    private let healthConfig: Configuration.Health
    
    init(
        healthRepository: HealthRepository,
        getWeeklyStepcount: GetWeeklyStepCount,
        healthConfig: Configuration.Health
    ) {
        self.healthRepository = healthRepository
        self.getWeeklyStepcount = getWeeklyStepcount
        self.healthConfig = healthConfig
    }
    
    func callAsFunction() async throws -> String {
        let weeklySteps = try await getWeeklyStepcount();
        let includedSteps = weeklySteps.filter { entity in
            let startOfToday = DateUtils.startOfDate(for: Date.now)
            return entity.date < startOfToday
                && !entity.isSubmitted!
                && entity.steps >= Double(healthConfig.stepLimit);
        }
        guard !includedSteps.isEmpty else {
            throw "Keine Schritte zum Übertragen"
        }
        return try await healthRepository.claimDiscount(with: includedSteps)
    }
}

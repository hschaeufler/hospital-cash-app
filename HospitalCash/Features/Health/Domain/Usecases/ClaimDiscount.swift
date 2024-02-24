//
//  CleaimDiscount.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 24.02.24.
//

import Foundation

protocol ClaimDiscount {
    func callAsFunction() async throws -> String
}

struct CleaimDiscountUseCase: ClaimDiscount {
    private let healthRepository: HealthRepository
    private let getWeeklyStepcount: GetWeeklyStepCount
    
    init(
        healthRepository: HealthRepository,
        getWeeklyStepcount: GetWeeklyStepCount
    ) {
        self.healthRepository = healthRepository
        self.getWeeklyStepcount = getWeeklyStepcount
    }
    
    //   (entity.isSubmitted ?? false)! && entity.date.
    
    func callAsFunction() async throws -> String {
        let weeklySteps = try await getWeeklyStepcount();
        let includedSteps = weeklySteps.filter { entity in
            let startOfToday = Calendar.current.startOfDay(for: Date.now)
            return entity.date < startOfToday && !entity.isSubmitted!;
        }
        return try await healthRepository.claimDiscount(with: includedSteps)
    }
}

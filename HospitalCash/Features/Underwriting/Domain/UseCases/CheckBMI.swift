//
//  CheckBMI.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 11.02.24.
//

import Foundation

protocol CheckBMI {
    func callAsFunction(heightInCm: Int, weightInKg: Int) async throws -> Bool
}

struct CheckBMIUseCase: CheckBMI {
    private let premiumRepository: PremiumRepository
    
    init(premiumRepository: PremiumRepository) {
        self.premiumRepository = premiumRepository
    }
    
    func callAsFunction(heightInCm: Int, weightInKg: Int) async throws -> Bool {
        try await premiumRepository.checkBMI(heightInCm: heightInCm, weightInKg: weightInKg)
    }
}

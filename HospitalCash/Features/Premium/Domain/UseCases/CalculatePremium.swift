//
//  CalculatePremiumUseCase.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 09.02.24.
//

import Foundation

protocol CalculatePremium {
    func callAsFunction(ethAmount: Double) async throws -> Double
}

struct CalculatePremiumUseCase: CalculatePremium {
    private let insuranceRepository: InsuranceRepository
    
    init(insuranceRepository: InsuranceRepository) {
        self.insuranceRepository = insuranceRepository
    }
 
    func callAsFunction(ethAmount: Double, isuranceStartData: Date, birthDate: Date) async throws -> Double {
        try await insuranceRepository.calculatePremium()
    }
}

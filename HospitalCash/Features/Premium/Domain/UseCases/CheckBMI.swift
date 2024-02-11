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
    private let insuranceRepository: InsuranceRepository
    
    init(insuranceRepository: InsuranceRepository) {
        self.insuranceRepository = insuranceRepository
    }
    
    func callAsFunction(heightInCm: Int, weightInKg: Int) async throws -> Bool {
        try await insuranceRepository.checkBMI(heightInCm: heightInCm, weightInKg: weightInKg)
    }
}

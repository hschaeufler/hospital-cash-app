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
    private let contractRepository: ContractRepository
    
    init(contractRepository: ContractRepository) {
        self.contractRepository = contractRepository
    }
    
    func callAsFunction(heightInCm: Int, weightInKg: Int) async throws -> Bool {
        try await contractRepository.checkBMI(heightInCm: heightInCm, weightInKg: weightInKg)
    }
}

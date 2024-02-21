//
//  GetContract.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 21.02.24.
//

import Foundation

protocol GetContract {
    func callAsFunction() async throws -> InsuranceContractEntity?
}

struct GetContractUseCase: GetContract {
    private let insuranceRepository: InsuranceRepository
    
    init(insuranceRepository: InsuranceRepository) {
        self.insuranceRepository = insuranceRepository
    }
    
    func callAsFunction() async throws -> InsuranceContractEntity? {
        return try await insuranceRepository.getContract()
    }
}

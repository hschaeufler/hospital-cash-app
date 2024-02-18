//
//  UnderwriteContract.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 17.02.24.
//

import Foundation

protocol UnderwriteContract {
    func callAsFunction(
        with application: ContractApplicationEntity
    ) async throws -> ContractEntity
}

struct UnderwriteContractUseCase: UnderwriteContract {
    let insuranceRepository: InsuranceRepository
    
    init(insuranceRepository: InsuranceRepository) {
        self.insuranceRepository = insuranceRepository
    }
    
    func callAsFunction(
        with application: ContractApplicationEntity
    ) async throws -> ContractEntity {
        return try await insuranceRepository.underwriteContract(with: application);
    }
}
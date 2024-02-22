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
    ) async throws -> String
}

struct UnderwriteContractUseCase: UnderwriteContract {
    let insuranceRepository: ContractRepository
    
    init(insuranceRepository: ContractRepository) {
        self.insuranceRepository = insuranceRepository
    }
    
    func callAsFunction(
        with application: ContractApplicationEntity
    ) async throws -> String {
        return try await insuranceRepository.underwriteContract(with: application);
    }
}

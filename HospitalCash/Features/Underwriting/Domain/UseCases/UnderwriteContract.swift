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
    let contractRepository: ContractRepository
    
    init(contractRepository: ContractRepository) {
        self.contractRepository = contractRepository
    }
    
    func callAsFunction(
        with application: ContractApplicationEntity
    ) async throws -> String {
        return try await contractRepository.underwriteContract(with: application);
    }
}

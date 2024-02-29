//
//  GetValidContract.swift
//  HospitalCash
//
//  Created by hschaeufler on 21.02.24.
//

import Foundation

protocol GetValidContract {
    func callAsFunction() async throws -> ContractEntity?
}

struct GetValidContractUseCase: GetValidContract {
    private let contractRepository: ContractRepository
    
    init(contractRepository: ContractRepository) {
        self.contractRepository = contractRepository
    }
    
    func callAsFunction() async throws -> ContractEntity? {
        return try await contractRepository.getValidContract()
    }
}

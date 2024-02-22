//
//  GetValidContract.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 21.02.24.
//

import Foundation

protocol GetValidContract {
    func callAsFunction() async throws -> InsuranceContractEntity?
}

struct GetValidContractUseCase: GetValidContract {
    private let contractRepository: ContractRepository
    
    init(contractRepository: ContractRepository) {
        self.contractRepository = contractRepository
    }
    
    func callAsFunction() async throws -> InsuranceContractEntity? {
        return try await contractRepository.getValidContract()
    }
}

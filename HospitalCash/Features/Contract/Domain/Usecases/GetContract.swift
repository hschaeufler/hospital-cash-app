//
//  GetContract.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import Foundation

protocol GetContract {
    func callAsFunction() async throws -> ContractEntity?
}

struct GetContractUseCase: GetContract {
    private let contractRepository: ContractRepository
    
    init(contractRepository: ContractRepository) {
        self.contractRepository = contractRepository
    }
    
    func callAsFunction() async throws -> ContractEntity? {
        return try await contractRepository.getContract()
    }
}

//
//  HasContract.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 22.02.24.
//

import Foundation

protocol HasContract {
    func callAsFunction() async throws -> InsuranceContractEntity?
}

struct HasContractUseCase: HasContract {
    private let contractRepository: ContractRepository
    
    init(contractRepository: ContractRepository) {
        self.contractRepository = contractRepository
    }
    
    func callAsFunction() async throws -> InsuranceContractEntity? {
        return try await contractRepository.getContract()
    }
}

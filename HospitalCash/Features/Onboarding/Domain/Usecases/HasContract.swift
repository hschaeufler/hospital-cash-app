//
//  HasContract.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 22.02.24.
//

import Foundation

protocol HasContract {
    func callAsFunction() async throws -> Bool
}

struct HasContractUseCase: HasContract {
    private let isWalletConnected: IsWalletConnected
    private let contractRepository: ContractRepository
    
    init(
        isWalletConnected: IsWalletConnected,
         contractRepository: ContractRepository
    ) {
        self.isWalletConnected = isWalletConnected
        self.contractRepository = contractRepository
    }
    
    func callAsFunction() async throws -> Bool {
        guard self.isWalletConnected() else {
            return false
        }
        return try await contractRepository.hasContract()
    }
}

//
//  GetTransactionState.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 21.02.24.
//

import Foundation

protocol GetTransactionState {
    func callAsFunction(with tx: String) async throws -> TransactionStateEntity
}

struct GetTransactionStateUseCase: GetTransactionState {
    private let ethereumRepository: EthereumRepository
    
    init(ethereumRepository: EthereumRepository) {
        self.ethereumRepository = ethereumRepository
    }
    
    func callAsFunction(with tx: String) async throws -> TransactionStateEntity {
        return try await ethereumRepository.getTransactionState(with: tx)
    }
}

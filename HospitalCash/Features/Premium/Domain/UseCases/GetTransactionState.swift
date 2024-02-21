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
    private let insuranceRepository: InsuranceRepository
    
    init(insuranceRepository: InsuranceRepository) {
        self.insuranceRepository = insuranceRepository
    }
    
    func callAsFunction(with tx: String) async throws -> TransactionStateEntity {
        return try await insuranceRepository.getTransactionState(with: tx)
    }
}

//
//  GetContractByTransaction.swift
//  HospitalCash
//
//  Created by hschaeufler on 21.02.24.
//

import Foundation

protocol GetContractByTransaction {
    func callAsFunction(with tx: String) async throws -> ContractEntity?
}

struct GetContractByTransactionUseCase: GetContractByTransaction {
    private let getValidContract: GetValidContract
    private let getTransactionState: GetTransactionState
    
    init(
        getValidContract: GetValidContract,
        getTransactionState: GetTransactionState
    ) {
        self.getTransactionState = getTransactionState
        self.getValidContract = getValidContract
    }
    
    func callAsFunction(with tx: String) async throws -> ContractEntity? {
        let transactionStatus = try await getTransactionState(with: tx)
        switch transactionStatus {
        case .failure:
            throw CommonError.contractExecutionError(message: "Transaction fehlerhaft")
        case .success:
            return try await self.getValidContract()
        case .notProcessed:
            return nil
        }
    }
}

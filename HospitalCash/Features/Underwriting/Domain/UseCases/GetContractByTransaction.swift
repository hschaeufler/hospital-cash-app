//
//  GetContractByTransaction.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 21.02.24.
//

import Foundation

protocol GetContractByTransaction {
    func callAsFunction(with tx: String) async throws -> InsuranceContractEntity?
}

struct GetContractByTransactionUseCase: GetContractByTransaction {
    private let getValidContract: GetValidContract
    private let getTransactionState: GetTransactionState
    
    init(
        getContract: GetValidContract,
        getTransactionState: GetTransactionState
    ) {
        self.getTransactionState = getTransactionState
        self.getValidContract = getContract
    }
    
    func callAsFunction(with tx: String) async throws -> InsuranceContractEntity? {
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
//
//  BlockchainRepository.swift
//  HospitalCash
//
//  Created by hschaeufler on 21.02.24.
//

import Foundation

class EthereumRepositoryImpl: EthereumRepository {
    let remoteDatasource: EthereumRemoteDatasource
    
    init(remoteDatasource: EthereumRemoteDatasource) {
        self.remoteDatasource = remoteDatasource
    }
    
    
    func getTransactionState(with tx: String) async throws -> TransactionStateEntity {
        return try await remoteDatasource
            .getTransactionReciept(with: tx)
            .status
            .toEntity();
    }
}

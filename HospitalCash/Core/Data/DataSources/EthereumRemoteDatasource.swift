//
//  EthereumRemoteDatasource.swift
//  HospitalCash
//
//  Created by hschaeufler on 21.02.24.
//

import Foundation
import web3

protocol EthereumRemoteDatasource {
    func getTransactionReciept(
        with tx: String
    ) async throws -> EthereumTransactionReceipt
}

class EthereumRemoteDatasourceImpl: EthereumRemoteDatasource {
    let client: EthereumHttpClient
    
    init(client: EthereumHttpClient) {
        self.client = client
    }
    
    func getTransactionReciept(
        with tx: String
    ) async throws -> EthereumTransactionReceipt {
        return try await client.eth_getTransactionReceipt(txHash: tx)
    }
}

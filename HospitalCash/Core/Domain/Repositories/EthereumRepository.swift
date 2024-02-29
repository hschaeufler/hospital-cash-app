//
//  EthereumRepository.swift
//  HospitalCash
//
//  Created by hschaeufler on 21.02.24.
//

import Foundation

protocol EthereumRepository {
    func getTransactionState(with tx: String) async throws -> TransactionStateEntity
}

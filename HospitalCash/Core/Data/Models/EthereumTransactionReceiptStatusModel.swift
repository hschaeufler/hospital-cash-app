//
//  EthereumTransactionReceiptStatusModel.swift
//  HospitalCash
//
//  Created by hschaeufler on 21.02.24.
//

import Foundation
import web3

extension EthereumTransactionReceiptStatus {
    func toEntity() -> TransactionStateEntity {
        switch self {
        case .success:
            return .success
        case .failure:
            return .failure
        case .notProcessed:
            return .notProcessed
        }
    }
}

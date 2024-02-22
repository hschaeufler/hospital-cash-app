//
//  HasContract.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 22.02.24.
//

import Foundation

protocol GetAppState {
    func callAsFunction() async throws -> AppState
}

struct GetAppStateUseCase: GetAppState {
    private let isWalletConnected: IsWalletConnected
    private let contractRepository: ContractRepository
    
    init(
        isWalletConnected: IsWalletConnected,
         contractRepository: ContractRepository
    ) {
        self.isWalletConnected = isWalletConnected
        self.contractRepository = contractRepository
    }
    
    func callAsFunction() async throws -> AppState {
        guard self.isWalletConnected() else {
            return AppState.initial
        }
        let hasContract = try await contractRepository.hasContract()
        return hasContract ? AppState.hasContract : AppState.isConnected
    }
}

//
//  ConnectWallet.swift
//  HospitalCash
//
//  Created by hschaeufler on 21.02.24.
//

import Foundation

protocol ConnectWallet {
    func callAsFunction() async throws -> String
}

struct ConnectWalletUseCase: ConnectWallet {
    private let walletRepository: WalletRepository
    
    init(walletRepository: WalletRepository) {
        self.walletRepository = walletRepository
    }
    
    func callAsFunction() async throws -> String {
        return try await walletRepository.connectWallet();
    }
}

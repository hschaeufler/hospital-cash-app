//
//  DisconnectWallet.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import Foundation

protocol DisconnectWallet {
    func callAsFunction()
}

struct DisconnectWalletUseCase: DisconnectWallet {
    private let walletRepository: WalletRepository
    
    init(walletRepository: WalletRepository) {
        self.walletRepository = walletRepository
    }
    
    func callAsFunction() {
        self.walletRepository.disconnectWallet()
    }
}

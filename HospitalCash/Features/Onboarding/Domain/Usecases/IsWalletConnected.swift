//
//  IsWalletConnected.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 22.02.24.
//

import Foundation

protocol IsWalletConnected {
    func callAsFunction() -> Bool
}

struct IsWalletConnectedUsecase: IsWalletConnected {
    let walletRepository: WalletRepository
    
    init(walletRepository: WalletRepository) {
        self.walletRepository = walletRepository
    }
    
    func callAsFunction() -> Bool {
        return walletRepository.getWalletAddress().isEmpty
    }
    
    
}

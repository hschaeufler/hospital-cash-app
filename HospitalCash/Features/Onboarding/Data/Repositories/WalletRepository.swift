//
//  WalletRepository.swift
//  HospitalCash
//
//  Created by hschaeufler on 21.02.24.
//

import Foundation


protocol WalletRepository {
    func connectWallet() async throws -> String
    func getWalletAddress() -> String
    func disconnectWallet()
}

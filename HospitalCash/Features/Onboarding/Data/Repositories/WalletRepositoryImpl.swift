//
//  WalletRepositoryImpl.swift
//  HospitalCash
//
//  Created by hschaeufler on 22.02.24.
//

import Foundation


class WalletRepositoryImpl: WalletRepository {
    let walletLocalDatasource: WalletLocalDataSource
    
    init(
        walletLocalDatasource: WalletLocalDataSource
    ) {
        self.walletLocalDatasource = walletLocalDatasource
    }

    func connectWallet() async throws -> String {
        return try await walletLocalDatasource.connectWallet();
    }
    
    func getWalletAddress() -> String {
        return walletLocalDatasource.getWalletAdress();
    }
    
    func disconnectWallet() {
        walletLocalDatasource.disconnectWallet()
    }
}

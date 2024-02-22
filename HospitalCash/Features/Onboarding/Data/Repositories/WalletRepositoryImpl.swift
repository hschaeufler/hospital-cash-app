//
//  WalletRepositoryImpl.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 22.02.24.
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
}

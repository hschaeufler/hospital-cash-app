//
//  WalletLocalDataSource.swift
//  HospitalCash
//
//  Created by hschaeufler on 31.01.24.
//

import Foundation
import metamask_ios_sdk
import web3
import BigInt
import Combine

protocol WalletLocalDataSource {
    func sendTransaction<T: CodableData>(with model: T) async throws -> String
    func connectWallet() async throws -> String
    func disconnectWallet()
    func getWalletAdress() -> String
}

public class WalletLocalDataSourceImpl: WalletLocalDataSource {
    private let metaMaskSDK: MetaMaskSDK
    private let config: Configuration.Wallet
    
    init(walletConfig: Configuration.Wallet) {
        let appMetaData = AppMetadata(
            name: walletConfig.dappName,
            url: walletConfig.dappUrl,
            iconUrl: walletConfig.dappIconUrl
        )
        self.metaMaskSDK = MetaMaskSDK.shared(appMetaData, sdkOptions: nil)
        self.config = walletConfig
    }
    
    func connectWallet() async throws -> String {
        if metaMaskSDK.account.isEmpty {
            metaMaskSDK.clearSession()
            let connectionResult = await metaMaskSDK.connect()
            if case .failure(let error) = connectionResult {
                throw error
            }
        }
        return metaMaskSDK.account;
    }
    
    func disconnectWallet() {
        metaMaskSDK.disconnect()
    }
    
    func sendTransaction<T: CodableData>(with model: T) async throws -> String {
        // Call estimate Gas to simulate sendTransaction end get possible errors
        let estimateGasRequest = EthereumRequest(
            method:  .ethEstimateGas,
            params: [model]
        )
        let transactionRequest = EthereumRequest(
            method: .ethSendTransaction,
            params: [model]
        )
        let transactionResult = await metaMaskSDK.batchRequest([
            estimateGasRequest,
            transactionRequest
        ]);
        
        switch transactionResult {
        case let .success(result):
            return result[1]
        case let .failure(error):
            throw error
        }
    }
    
    func getWalletAdress() -> String {
        return metaMaskSDK.account;
    }
    
}

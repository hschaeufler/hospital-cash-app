//
//  WalletLocalDataSource.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 31.01.24.
//

import Foundation
import metamask_ios_sdk
import web3
import BigInt
import Combine

protocol WalletLocalDataSource {
    func underwriteContract(with model: UnderwriteContractRequestModel) async throws -> String
    func connectWallet() async throws -> String
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
            let connectionResult = await metaMaskSDK.connect()
            if case .failure(let error) = connectionResult {
                throw error
            }
        }
        return metaMaskSDK.account;
    }
    
    func underwriteContract(with model: UnderwriteContractRequestModel) async throws -> String {
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

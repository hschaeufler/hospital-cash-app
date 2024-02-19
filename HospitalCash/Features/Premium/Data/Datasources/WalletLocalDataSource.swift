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
    func underwriteContract(with model: UnderwriteContractRequestModel) async throws -> UnderwriteContractResponseModel
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
    
    func underwriteContract(with model: UnderwriteContractRequestModel) async throws -> UnderwriteContractResponseModel {
        let transactionRequest = EthereumRequest(
            method: .ethSendTransaction,
            params: [model]
        )
        let transactionResult = await metaMaskSDK.connectWith(transactionRequest);
        
        switch transactionResult {
        case let .success(value):
            return try UnderwriteContractResponseModel(data: value)!
        case let .failure(error):
            throw error
        }
    }
    
}

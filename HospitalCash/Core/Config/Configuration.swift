//
//  Configuration.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 09.02.24.
//
//  See: https://cocoacasts.com/cocoa-fundamentals-how-to-access-builds-settings-in-swift

import Foundation

struct Configuration {
    struct InsuranceContract {
        private static let nodeRpcEndpointKey = "NODE_RPC_ENDPOINT"
        private static let chainIdKey = "CHAIN_ID"
        private static let contractAdressKey = "CONTRACT_ADRESS"
        
        var nodeRpcEndpoint: URL {
            URL(string: getConfigValue(forKey: InsuranceContract.nodeRpcEndpointKey))!
        }
        
        var chainId: String {
            getConfigValue(forKey: InsuranceContract.chainIdKey)
        }
        
        var contractAdress: String {
            getConfigValue(forKey: InsuranceContract.contractAdressKey)
        }
    }
    
    struct Wallet {
        private static let dappNameKey = "DAPP_NAME"
        private static let dappUrlKey = "DAPP_URL"
        private static let dappIconUrlKey = "DAPP_ICON_URL"

        var dappName: String {
            getConfigValue(forKey: Wallet.dappNameKey)
        }
        
        var dappUrl: String {
            getConfigValue(forKey: Wallet.dappUrlKey)
        }
        
        var dappIconUrl: String {
            getConfigValue(forKey: Wallet.dappIconUrlKey)
        }
    }
    
    static private func getConfigValue(forKey: String) -> String {
        Bundle.main.object(forInfoDictionaryKey: forKey) as! String
    }
    
    static private func getConfigValue(forKey: String) -> Int {
        Bundle.main.object(forInfoDictionaryKey: forKey) as! Int
    }
}

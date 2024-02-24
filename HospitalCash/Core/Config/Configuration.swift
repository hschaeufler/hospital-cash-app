//
//  Configuration.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 09.02.24.
//
//  See: https://cocoacasts.com/cocoa-fundamentals-how-to-access-builds-settings-in-swift

import Foundation

struct Configuration {
    struct Client {
        private static let nodeRpcEndpointKey = "NODE_RPC_ENDPOINT"
        private static let chainIdKey = "CHAIN_ID"
        
        var nodeRpcEndpoint: URL {
            URL(string: getConfigValue(forKey: Client.nodeRpcEndpointKey))!
        }
        
        var chainId: String {
            getConfigValue(forKey: Client.chainIdKey)
        }
    }
    
    struct Contract {
        private static let contractAdressKey = "CONTRACT_ADRESS"
        
        var contractAdress: String {
            getConfigValue(forKey: Contract.contractAdressKey)
        }
    }
    
    struct Wallet {
        private static let dappNameKey = "DAPP_NAME"
        private static let dappUrlKey = "DAPP_URL"
        private static let dappIconUrlKey = "DAPP_ICON_URL"
        private static let contractAdress = "CONTRACT_ADRESS"

        var dappName: String {
            getConfigValue(forKey: Wallet.dappNameKey)
        }
        
        var dappUrl: String {
            getConfigValue(forKey: Wallet.dappUrlKey)
        }
        
        var dappIconUrl: String {
            getConfigValue(forKey: Wallet.dappIconUrlKey)
        }
        
        var contractAdress: String {
            getConfigValue(forKey: Wallet.contractAdress)
        }
    }
    
    struct Health {
        private static let stepLimit = "STEP_LIMIT"

        var stepLimit: Int {
            getConfigValue(forKey: Health.stepLimit)
        }
    }
    
    static private func getConfigValue(forKey: String) -> String {
        Bundle.main.object(forInfoDictionaryKey: forKey) as! String
    }
    
    static private func getConfigValue(forKey: String) -> Int {
        Int(Bundle.main.object(forInfoDictionaryKey: forKey) as! String)!
    }
}

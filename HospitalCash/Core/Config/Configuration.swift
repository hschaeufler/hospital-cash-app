//
//  Configuration.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 09.02.24.
//
//  See: https://cocoacasts.com/cocoa-fundamentals-how-to-access-builds-settings-in-swift

import Foundation

enum Configuration {
    private static let nodeRpcEndpointKey = "NODE_RPC_ENDPOINT"
    private static let chainIdKey = "CHAIN_ID"
    private static let contractAdressKey = "CONTRACT_ADRESS"
    
    static var nodeRpcEndpoint: URL {
        URL(string: getConfigValue(forKey: nodeRpcEndpointKey))!
    }
    
    static var chainId: String {
        getConfigValue(forKey: chainIdKey)
    }
    
    static var contractAdress: String {
        getConfigValue(forKey: contractAdressKey)
    }
    
    static private func getConfigValue(forKey: String) -> String {
        Bundle.main.value(forKey: forKey) as! String
    }
    
    static private func getConfigValue(forKey: String) -> Int {
        Bundle.main.value(forKey: forKey) as! Int
    }
}

//
//  ExchangeRateRemoteDatasource.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 31.01.24.
//

import Foundation
import metamask_ios_sdk
import web3
import BigInt
import Combine

protocol MetamaskSDKDatasource {
    func callSmartContract() async throws -> String
}

public class MetamaskDatasourceImpl: MetamaskSDKDatasource {
    private let metaMaskSDK: MetaMaskSDK
    
    init() {
        let appMetaData = AppMetadata(
            name: "Hospital Cash",
            url: "https://the-wallet.dev"
        )
        metaMaskSDK = MetaMaskSDK.shared(appMetaData, sdkOptions: nil)
    }
    
    
    
    public func callSmartContract() async throws -> String {
        let contractAdress =  "0x8936FD38C5AcC5a6CFfb3841153EC604E215309E"
        let model = GetHospitalCashPremiumModel(
            EthereumAddress(contractAdress),
            birthDateTs: 728784534,
            insuranceStartDateTs: 1714514400,
            hospitalCashInWei: 100000
        )
        
        
        let connection = await metaMaskSDK.connect()
        switch connection {
        case let .failure(error):
            print(error)
            throw error
        default:
            break
        }
        
        /*let contractAdress =  "0x8936FD38C5AcC5a6CFfb3841153EC604E215309E"
        let model = GetHospitalCashPremiumModel(
            EthereumAddress(contractAdress),
            birthDateTs: 728784534,
            insuranceStartDateTs: 1714514400,
            hospitalCashInWei: 100000
        )*/
        
        let hexString = model.toHexString()
        print(hexString)
        
        let parameters: [String: String] = [
            "to": contractAdress, // receiver address
            "data": hexString,
            "chainId": "0x539"
        ]
        
        
        let ethRequest = EthereumRequest(
            method: .ethCall,
            params: [parameters]
        )
        
        let result = await metaMaskSDK.request(ethRequest)
        switch result {
        case let .success(value):
            let result = try ABIDecoder.decode(value, to: BigUInt.self)
            return result.formatted()
        case let .failure(error):
            print(error)
            print(error.message)
            print(error.localizedDescription)
            throw error
        }
    }
    
}

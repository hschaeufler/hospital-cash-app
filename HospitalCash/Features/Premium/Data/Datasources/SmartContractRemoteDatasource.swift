//
//  ExchangeRateRemoteDatasource.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 31.01.24.
//

import Foundation
import web3


protocol SmartContractRemoteDatasource {
    func callSmartContract() async throws -> String
}

public class SmartContractRemoteDatasourceImpl: SmartContractRemoteDatasource {

    init() {}
    
    
    
    public func callSmartContract() async throws -> String {
        let clientUrl = URL(string: "http://192.168.178.86:8545")
        let client = EthereumHttpClient(url: clientUrl!, network: EthereumNetwork.fromString("1337"))
        let contractAdress =  "0x8936FD38C5AcC5a6CFfb3841153EC604E215309E"
        let function = HospitalCashSmartContractModel.getHospitalCashPremiumFunction(EthereumAddress(contractAdress), birthDateTs: 1675364248, insuranceStartDateTs: 1714514400, hospitalCashInWei: 100000)
        do {
            print("test")
            let data = try await function.call(withClient: client, responseType: HospitalCashSmartContractModel.getHospitalCashPremiumResponse.self, resolution: .noOffchain(failOnExecutionError: true))
            return data.value.formatted()
        } catch {
            print("Alarm!!!!")
            print(error)
            print("Alarm2!!!")
            print(error.localizedDescription)
            print("Alarm!!!!")
            print("0x08c379a000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000018506572736f6e206d75737420626520616e206164756c74210000000000000000".web3.hexData)
        }
        return ""
    }
    
}

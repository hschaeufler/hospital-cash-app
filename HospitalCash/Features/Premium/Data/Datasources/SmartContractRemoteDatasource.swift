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
            let data = try await function.call(withClient: client, responseType: HospitalCashSmartContractModel.getHospitalCashPremiumResponse.self, resolution: .noOffchain(failOnExecutionError: true))
            return data.value.formatted()
        } catch {
            print(error)
            print(error.localizedDescription)
        }
        return ""
    }
    
}

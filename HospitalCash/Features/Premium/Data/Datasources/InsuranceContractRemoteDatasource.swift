//
//  InsuranceContractRemoteDatasource.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 31.01.24.
//

import Foundation
import web3


protocol InsuranceContractRemoteDatasource {
    func callSmartContract() async throws -> String
}

public class SmartContractRemoteDatasourceImpl: InsuranceContractRemoteDatasource {
    let client: EthereumHttpClient
    let contractAdress: EthereumAddress
    
    init() {
        let network = EthereumNetwork.fromString(Configuration.chainId)
        self.client = EthereumHttpClient(
            url: Configuration.nodeRpcEndpoint,
            network: network
        )
        self.contractAdress = EthereumAddress(Configuration.contractAdress)
    }
    
    public func callSmartContract() async throws -> String {
        let function = HospitalCashSmartContractModel.getHospitalCashPremiumFunction(
            self.contractAdress,
            birthDateTs: 1675364248,
            insuranceStartDateTs: 1714514400,
            hospitalCashInWei: 100000
        )
        let data = try await function.call(
            withClient: client,
            responseType: HospitalCashSmartContractModel.getHospitalCashPremiumResponse.self
        )
        return data.value.formatted()
    }
    
}

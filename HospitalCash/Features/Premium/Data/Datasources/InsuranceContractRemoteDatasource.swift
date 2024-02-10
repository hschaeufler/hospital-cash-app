//
//  InsuranceContractRemoteDatasource.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 31.01.24.
//

import Foundation
import web3


protocol InsuranceContractRemoteDatasource {
    func getContractAdress() -> EthereumAddress
    func callSmartContract(with: GetPremiumRequestModel) async throws -> GetPremiumResponseModel
}

public class InsuranceContractRemoteDatasourceImpl: InsuranceContractRemoteDatasource {
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
    
    func getContractAdress() -> EthereumAddress {
        self.contractAdress
    }
    
    func callSmartContract(with: GetPremiumRequestModel) async throws -> GetPremiumResponseModel {
        try await with.call(
            withClient: client,
            responseType: GetPremiumResponseModel.self
        )
    }
    
}

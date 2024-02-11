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
    func getMonthlyPremium(with: GetMonthlyPremiumRequestModel) async throws -> GetMonthlyPremiumResponseModel
    func checkBMI(with: CheckBMIRequestModel) async throws -> CheckBMIResponseModel
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
    
    func getMonthlyPremium(with model: GetMonthlyPremiumRequestModel) async throws -> GetMonthlyPremiumResponseModel {
        try await model.call(
            withClient: client,
            responseType: GetMonthlyPremiumResponseModel.self
        )
    }
    
    func checkBMI(with model: CheckBMIRequestModel) async throws -> CheckBMIResponseModel {
        try await model.call(
            withClient: client,
            responseType: CheckBMIResponseModel.self
        )
    }
    
}

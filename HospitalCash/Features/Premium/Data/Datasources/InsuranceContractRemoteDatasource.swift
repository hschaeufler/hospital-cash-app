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
    func getMonthlyPremium(with model: GetMonthlyPremiumRequestModel) async throws -> GetMonthlyPremiumResponseModel
    func checkBMI(with model: CheckBMIRequestModel) async throws -> CheckBMIResponseModel
    func checkHealthQuestions(with model: CheckHealthQuestionsRequestModel) async throws -> CheckHealthQuestionsResponseModel
}

public class InsuranceContractRemoteDatasourceImpl: InsuranceContractRemoteDatasource {
    let client: EthereumHttpClient
    let contractAdress: EthereumAddress
    
    init(contractConfig: Configuration.InsuranceContract) {
        let network = EthereumNetwork.fromString(contractConfig.chainId)
        self.client = EthereumHttpClient(
            url: contractConfig.nodeRpcEndpoint,
            network: network
        )
        self.contractAdress = EthereumAddress(contractConfig.contractAdress)
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
    
    func checkHealthQuestions(with model: CheckHealthQuestionsRequestModel) async throws -> CheckHealthQuestionsResponseModel {
        try await model.call(
            withClient: client,
            responseType: CheckHealthQuestionsResponseModel.self
        )
    }
}

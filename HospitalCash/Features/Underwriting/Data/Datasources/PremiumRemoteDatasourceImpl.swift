//
//  PremiumRemoteDatasource.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import Foundation
import web3


protocol PremiumRemoteDatasource {
    func getContractAdress() -> EthereumAddress
    func getMonthlyPremium(
        with model: GetMonthlyPremiumRequestModel
    ) async throws -> GetMonthlyPremiumResponseModel
    func checkBMI(
        with model: CheckBMIRequestModel
    ) async throws -> CheckBMIResponseModel
    func checkHealthQuestions(
        with model: CheckHealthQuestionsRequestModel
    ) async throws -> CheckHealthQuestionsResponseModel
}

class PremiumRemoteDatasourceImpl: PremiumRemoteDatasource {
    let client: EthereumHttpClient
    let contractAdress: EthereumAddress
    
    init(
        client: EthereumHttpClient,
        contractConfig: Configuration.Contract
    ) {
        self.client = client
        self.contractAdress = EthereumAddress(contractConfig.contractAdress)
    }
    
    func getContractAdress() -> EthereumAddress {
        self.contractAdress
    }
    
    func getMonthlyPremium(
        with model: GetMonthlyPremiumRequestModel
    ) async throws -> GetMonthlyPremiumResponseModel {
        try await model.call(
            withClient: client,
            responseType: GetMonthlyPremiumResponseModel.self
        )
    }
    
    func checkBMI(
        with model: CheckBMIRequestModel
    ) async throws -> CheckBMIResponseModel {
        try await model.call(
            withClient: client,
            responseType: CheckBMIResponseModel.self
        )
    }
    
    func checkHealthQuestions(
        with model: CheckHealthQuestionsRequestModel
    ) async throws -> CheckHealthQuestionsResponseModel {
        try await model.call(
            withClient: client,
            responseType: CheckHealthQuestionsResponseModel.self
        )
    }
}

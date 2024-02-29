//
//  HealthRemoteDatasource.swift
//  HospitalCash
//
//  Created by hschaeufler on 24.02.24.
//

import Foundation
import web3

protocol HealthRemoteDatasource {
    func getContractAdress() -> EthereumAddress
    func getLastPayOutDate(
        with model: GetLastPayOutDateRequestModel
    ) async throws -> GetLastPayOutDateResponseModel
}

class HealthRemoteDatasourceImpl: HealthRemoteDatasource {
    
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

    func getLastPayOutDate(
        with model: GetLastPayOutDateRequestModel
    ) async throws -> GetLastPayOutDateResponseModel {
        try await model.call(
            withClient: client,
            responseType: GetLastPayOutDateResponseModel.self
        )
    }
}

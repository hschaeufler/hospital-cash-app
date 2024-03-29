//
//  ContractRemoteDatasource.swift
//  HospitalCash
//
//  Created by hschaeufler on 31.01.24.
//

import Foundation
import web3


protocol ContractRemoteDatasource {
    func getContractAdress() -> EthereumAddress
    func getContract(
        with model: GetContractRequestModel
    ) async throws -> GetContractResponseModel
    func getValidContract(
        with model: GetValidContractRequestModel
    ) async throws -> GetValidContractResponseModel
    func hasContract(
        with model: HasContractRequestModel
    ) async throws -> HasContractResponseModel
    func hasValidContract(
        with model: HasValidContractRequestModel
    ) async throws -> HasValidContractResponseModel
    func getNewContractEvents(
        policyHolder: EthereumAddress,
        fromBlock: EthereumBlock,
        toBlock: EthereumBlock
    ) async throws -> [NewContractEventModel]
}

class ContractRemoteDatasourceImpl: ContractRemoteDatasource {
    
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
    
    func getValidContract(
        with model: GetValidContractRequestModel
    ) async throws -> GetValidContractResponseModel {
        try await model.call(
            withClient: client,
            responseType: GetValidContractResponseModel.self
        )
    }
    
    func getContract(
        with model: GetContractRequestModel
    ) async throws -> GetContractResponseModel {
        try await model.call(
            withClient: client,
            responseType: GetContractResponseModel.self
        )
    }
    
    func hasValidContract(
        with model: HasValidContractRequestModel
    ) async throws -> HasValidContractResponseModel {
        try await model.call(
            withClient: client,
            responseType: HasValidContractResponseModel.self
        )
    }
    
    func hasContract(
        with model: HasContractRequestModel
    ) async throws -> HasContractResponseModel {
        try await model.call(
            withClient: client,
            responseType: HasContractResponseModel.self
        )
    }
    
    func getNewContractEvents(policyHolder: EthereumAddress, fromBlock: EthereumBlock, toBlock: EthereumBlock) async throws -> [NewContractEventModel] {
        guard let result = try? ABIEncoder.encode(policyHolder).bytes, let sig = try? NewContractEventModel.signature() else {
            throw EthereumSignerError.unknownError
        }

        let data = try await client.getEvents(
            addresses: nil,
            topics: [sig, nil, String(hexFromBytes: result)],
            fromBlock: fromBlock,
            toBlock: toBlock,
            eventTypes: [NewContractEventModel.self]
        )

        if let events = data.events as? [NewContractEventModel] {
            return events
        } else {
            throw EthereumClientError.decodeIssue
        }
    }
}

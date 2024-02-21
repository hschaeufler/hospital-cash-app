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
    func getMonthlyPremium(
        with model: GetMonthlyPremiumRequestModel
    ) async throws -> GetMonthlyPremiumResponseModel
    func checkBMI(
        with model: CheckBMIRequestModel
    ) async throws -> CheckBMIResponseModel
    func checkHealthQuestions(
        with model: CheckHealthQuestionsRequestModel
    ) async throws -> CheckHealthQuestionsResponseModel
    func getTransactionReciept(
        with tx: String
    ) async throws -> EthereumTransactionReceipt
    func getContract(
        with model: GetContractRequestModel
    ) async throws -> GetContractResponseModel
    func getNewContractEvents(
        policyHolder: EthereumAddress,
        fromBlock: EthereumBlock,
        toBlock: EthereumBlock
    ) async throws -> [NewContractEventModel]
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
    
    func getTransactionReciept(
        with tx: String
    ) async throws -> EthereumTransactionReceipt {
        return try await client.eth_getTransactionReceipt(txHash: tx)
    }
    
    func getContract(
        with model: GetContractRequestModel
    ) async throws -> GetContractResponseModel {
        try await model.call(
            withClient: client,
            responseType: GetContractResponseModel.self
        )
    }
    
    func transferEventsTo(recipient: EthereumAddress, fromBlock: EthereumBlock, toBlock: EthereumBlock) async throws -> [ERC20Events.Transfer] {
        guard let result = try? ABIEncoder.encode(recipient).bytes, let sig = try? ERC20Events.Transfer.signature() else {
            throw EthereumSignerError.unknownError
        }

        let data = try await client.getEvents(
            addresses: nil,
            topics: [sig, nil, String(hexFromBytes: result)],
            fromBlock: fromBlock,
            toBlock: toBlock,
            eventTypes: [ERC20Events.Transfer.self]
        )

        if let events = data.events as? [ERC20Events.Transfer] {
            return events
        } else {
            throw EthereumClientError.decodeIssue
        }
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

//
//  ContractRepositoryImpl.swift
//  HospitalCash
//
//  Created by hschaeufler on 09.02.24.
//

import Foundation
import web3
import metamask_ios_sdk

class ContractRepositoryImpl: ContractRepository {
    let contractRemoteDatasource: ContractRemoteDatasource;
    let walletLocalDatasource: WalletLocalDataSource
    
    init(
        contractRemoteDatasource: ContractRemoteDatasource,
        walletLocalDatasource: WalletLocalDataSource
    ) {
        self.contractRemoteDatasource = contractRemoteDatasource
        self.walletLocalDatasource = walletLocalDatasource
    }
    
    func underwriteContract(
        with application: ContractApplicationEntity
    ) async throws -> String {
        let contractAdress = contractRemoteDatasource.getContractAdress()
        let walletAdress = walletLocalDatasource.getWalletAdress()
        do {
            let requestModel = try UnderwriteContractRequestModel.fromEntity(
                contractAdress,
                from: walletAdress,
                with: application
            )
            return try await walletLocalDatasource.sendTransaction(with: requestModel)
        } catch let error as RequestError {
            throw try error.toCommonError()
        }
    }
    
    func getValidContract() async throws -> ContractEntity? {
        let contractAdress = contractRemoteDatasource.getContractAdress()
        let walletAddress = walletLocalDatasource.getWalletAdress()
        let model = GetValidContractRequestModel(contractAdress, from: EthereumAddress(walletAddress))
        let result = try await contractRemoteDatasource.getValidContract(with: model)
        return result.isValid
        ? result.insuranceContract.toEntity()
        : nil;
    }
    
    func getContract() async throws -> ContractEntity? {
        let contractAdress = contractRemoteDatasource.getContractAdress()
        let walletAddress = walletLocalDatasource.getWalletAdress()
        let model = GetContractRequestModel(contractAdress, from: EthereumAddress(walletAddress))
        let result = try await contractRemoteDatasource.getContract(with: model)
        return result.isValid
        ? result.insuranceContract.toEntity()
        : nil;
    }
    
    func hasValidContract() async throws -> Bool {
        let contractAdress = contractRemoteDatasource.getContractAdress()
        let walletAddress = walletLocalDatasource.getWalletAdress()
        let model = HasValidContractRequestModel(contractAdress, from: EthereumAddress(walletAddress))
        let result = try await contractRemoteDatasource.hasValidContract(with: model)
        return result.value;
    }
    
    func hasContract() async throws -> Bool {
        let contractAdress = contractRemoteDatasource.getContractAdress()
        let walletAddress = walletLocalDatasource.getWalletAdress()
        let model = HasContractRequestModel(contractAdress, from: EthereumAddress(walletAddress))
        let result = try await contractRemoteDatasource.hasContract(with: model)
        return result.value;
    }
    
    func getNewContractEvent(address: String) async throws -> NewContractEventEntity? {
        return try await contractRemoteDatasource.getNewContractEvents(
            policyHolder: EthereumAddress(address),
            fromBlock: .Earliest,
            toBlock: .Latest
        ).map { model in
            model.toEntity()
        }.last
    }
}

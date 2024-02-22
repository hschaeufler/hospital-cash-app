//
//  ContractRepositoryImpl.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 09.02.24.
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
    
    func getMonthlyPremium(with entity: PremiumCalculationEntity) async throws -> Double {
        let contractAdress = contractRemoteDatasource.getContractAdress()
        let requestModel = GetMonthlyPremiumRequestModel.fromEntity(contractAdress, with: entity);
        do {
            let responseModel = try await contractRemoteDatasource
                .getMonthlyPremium(with: requestModel)
            return responseModel.toEth()!
        } catch EthereumClientError.executionError(let jsonRpcErrorDetail) {
            throw try jsonRpcErrorDetail.toCommonError()
        }
    }
    
    func checkBMI(heightInCm: Int, weightInKg: Int) async throws -> Bool {
        let contractAdress = contractRemoteDatasource.getContractAdress()
        let requestModel = CheckBMIRequestModel.fromEntity(contractAdress, heightInCm: heightInCm, weightInKg: weightInKg)
        do {
            let responseModel = try await contractRemoteDatasource.checkBMI(with: requestModel)
            return responseModel.isOk
        } catch EthereumClientError.executionError(let jsonRpcErrorDetail) {
            throw try jsonRpcErrorDetail.toCommonError()
        }
    }
    
    func checkHealthQuestions(with entity: HealthQuestionEntity) async throws -> Bool {
        let contractAdress = contractRemoteDatasource.getContractAdress()
        let requestModel = CheckHealthQuestionsRequestModel.fromEntity(contractAdress, with: entity)
        do {
            let responseModel = try await contractRemoteDatasource.checkHealthQuestions(with: requestModel)
            return responseModel.value
        } catch EthereumClientError.executionError(let jsonRpcErrorDetail) {
            throw try jsonRpcErrorDetail.toCommonError()
        }
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
    
    func getContract() async throws -> InsuranceContractEntity? {
        let contractAdress = contractRemoteDatasource.getContractAdress()
        let walletAddress = walletLocalDatasource.getWalletAdress()
        let model = GetContractRequestModel(contractAdress, from: EthereumAddress(walletAddress))
        let result = try await contractRemoteDatasource.getContract(with: model)
        return result.isValid
        ? result.insuranceContract.toEntity()
        : nil;
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

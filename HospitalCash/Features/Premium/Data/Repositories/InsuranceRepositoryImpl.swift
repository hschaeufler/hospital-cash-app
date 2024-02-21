//
//  InsuranceRepositoryImpl.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 09.02.24.
//

import Foundation
import web3
import metamask_ios_sdk

class InsuranceRepositoryImpl: InsuranceRepository {
    let insuranceContractRemoteDatasource: InsuranceContractRemoteDatasource;
    let walletLocalDatasource: WalletLocalDataSource
    
    init(
        insuracenContractRemoteDatasource: InsuranceContractRemoteDatasource,
        walletLocalDatasource: WalletLocalDataSource
    ) {
        self.insuranceContractRemoteDatasource = insuracenContractRemoteDatasource
        self.walletLocalDatasource = walletLocalDatasource
    }
    
    func getMonthlyPremium(with entity: PremiumCalculationEntity) async throws -> Double {
        let contractAdress = insuranceContractRemoteDatasource.getContractAdress()
        let requestModel = GetMonthlyPremiumRequestModel.fromEntity(contractAdress, with: entity);
        do {
            let responseModel = try await insuranceContractRemoteDatasource
                .getMonthlyPremium(with: requestModel)
            return responseModel.toEth()!
        } catch EthereumClientError.executionError(let jsonRpcErrorDetail) {
            throw try jsonRpcErrorDetail.toCommonError()
        }
    }
    
    func checkBMI(heightInCm: Int, weightInKg: Int) async throws -> Bool {
        let contractAdress = insuranceContractRemoteDatasource.getContractAdress()
        let requestModel = CheckBMIRequestModel.fromEntity(contractAdress, heightInCm: heightInCm, weightInKg: weightInKg)
        do {
            let responseModel = try await insuranceContractRemoteDatasource.checkBMI(with: requestModel)
            return responseModel.isOk
        } catch EthereumClientError.executionError(let jsonRpcErrorDetail) {
            throw try jsonRpcErrorDetail.toCommonError()
        }
    }
    
    func checkHealthQuestions(with entity: HealthQuestionEntity) async throws -> Bool {
        let contractAdress = insuranceContractRemoteDatasource.getContractAdress()
        let requestModel = CheckHealthQuestionsRequestModel.fromEntity(contractAdress, with: entity)
        do {
            let responseModel = try await insuranceContractRemoteDatasource.checkHealthQuestions(with: requestModel)
            return responseModel.value
        } catch EthereumClientError.executionError(let jsonRpcErrorDetail) {
            throw try jsonRpcErrorDetail.toCommonError()
        }
    }
    
    func underwriteContract(
        with application: ContractApplicationEntity
    ) async throws -> String {
        let contractAdress = insuranceContractRemoteDatasource.getContractAdress()
        do {
            let accountAdress = try await walletLocalDatasource.connectWallet();
            let requestModel = try UnderwriteContractRequestModel.fromEntity(
                contractAdress,
                from: accountAdress,
                with: application
            )
            return try await walletLocalDatasource.underwriteContract(with: requestModel)
        } catch let error as RequestError {
            throw try error.toCommonError()
        }
    }
    
    func getTransactionState(with tx: String) async throws -> TransactionStateEntity {
        return try await insuranceContractRemoteDatasource
            .getTransactionReciept(with: tx)
            .status
            .toEntity();
    }
    
    func getContract() async throws -> InsuranceContractEntity? {
        let contractAdress = insuranceContractRemoteDatasource.getContractAdress()
        let model = GetContractRequestModel(contractAdress)
        let result = try await insuranceContractRemoteDatasource.getContract(with: model)
        return result.isValid
        ? result.insuranceContract.toEntity()
        : nil;
    }
    
    func getNewContractEvent(address: String) async throws -> NewContractEventEntity? {
        return try await insuranceContractRemoteDatasource.getNewContractEvents(
            policyHolder: EthereumAddress(address),
            fromBlock: .Earliest,
            toBlock: .Latest
        ).map { model in
            model.toEntity()
        }.last
    }
    
    func connectWallet() async throws -> String {
        return try await walletLocalDatasource.connectWallet();
    }
    
    func getWalletAddress() -> String {
        return walletLocalDatasource.getWalletAdress();
    }
}

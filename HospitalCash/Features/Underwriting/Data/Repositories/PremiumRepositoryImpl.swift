//
//  PremiumRepositoryImpl.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import Foundation
import web3


class PremiumRepositoryImpl: PremiumRepository {
    let premiumRemoteDatasource: PremiumRemoteDatasource;
    let walletLocalDatasource: WalletLocalDataSource
    
    init(
        premiumRemoteDatasource: PremiumRemoteDatasource,
        walletLocalDatasource: WalletLocalDataSource
    ) {
        self.premiumRemoteDatasource = premiumRemoteDatasource
        self.walletLocalDatasource = walletLocalDatasource
    }
    
    func getMonthlyPremium(with entity: PremiumCalculationEntity) async throws -> Double {
        let contractAdress = premiumRemoteDatasource.getContractAdress()
        let requestModel = GetMonthlyPremiumRequestModel.fromEntity(contractAdress, with: entity);
        do {
            let responseModel = try await premiumRemoteDatasource
                .getMonthlyPremium(with: requestModel)
            return responseModel.toEth()!
        } catch EthereumClientError.executionError(let jsonRpcErrorDetail) {
            throw try jsonRpcErrorDetail.toCommonError()
        }
    }
    
    func checkBMI(heightInCm: Int, weightInKg: Int) async throws -> Bool {
        let contractAdress = premiumRemoteDatasource.getContractAdress()
        let requestModel = CheckBMIRequestModel.fromEntity(contractAdress, heightInCm: heightInCm, weightInKg: weightInKg)
        do {
            let responseModel = try await premiumRemoteDatasource.checkBMI(with: requestModel)
            return responseModel.isOk
        } catch EthereumClientError.executionError(let jsonRpcErrorDetail) {
            throw try jsonRpcErrorDetail.toCommonError()
        }
    }
    
    func checkHealthQuestions(with entity: HealthQuestionEntity) async throws -> Bool {
        let contractAdress = premiumRemoteDatasource.getContractAdress()
        let requestModel = CheckHealthQuestionsRequestModel.fromEntity(contractAdress, with: entity)
        do {
            let responseModel = try await premiumRemoteDatasource.checkHealthQuestions(with: requestModel)
            return responseModel.value
        } catch EthereumClientError.executionError(let jsonRpcErrorDetail) {
            throw try jsonRpcErrorDetail.toCommonError()
        }
    }
}

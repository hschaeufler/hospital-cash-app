//
//  InsuranceRepositoryImpl.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 09.02.24.
//

import Foundation
import web3

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
        with application: ContractApplicationEntity,
        and yearlyPremiumInEth: Double
    ) async throws -> InsuranceContractEntity {
        let contractAdress = insuranceContractRemoteDatasource.getContractAdress()
        let requestModel = try UnderwriteContractRequestModel.fromEntity(
            contractAdress,
            with: application,
            and: yearlyPremiumInEth
        )
        let responseModel = try await walletLocalDatasource.underwriteContract(with: requestModel)
        
    }
    
}

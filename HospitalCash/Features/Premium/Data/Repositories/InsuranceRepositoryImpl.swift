//
//  InsuranceRepositoryImpl.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 09.02.24.
//

import Foundation
import web3

class InsuranceRepositoryImpl: InsuranceRepository {
    let insuracenContractRemoteDatasource: InsuranceContractRemoteDatasource;
    
    init(insuracenContractRemoteDatasource: InsuranceContractRemoteDatasource) {
        self.insuracenContractRemoteDatasource = insuracenContractRemoteDatasource
    }
    
    func getMonthlyPremium(with entity: PremiumCalculationEntity) async throws -> Double {
        let contractAdress = insuracenContractRemoteDatasource.getContractAdress()
        let requestModel = GetMonthlyPremiumRequestModel.fromEntity(contractAdress, with: entity);
        do {
            let responseModel = try await insuracenContractRemoteDatasource
                .getMonthlyPremium(with: requestModel)
            return responseModel.toEth()!
        } catch EthereumClientError.executionError(let jsonRpcErrorDetail) {
            throw try jsonRpcErrorDetail.toCommonError()
        }
    }
    
    func checkBMI(heightInCm: Int, weightInKg: Int) async throws -> Bool {
        let contractAdress = insuracenContractRemoteDatasource.getContractAdress()
        let requestModel = CheckBMIRequestModel.fromEntity(contractAdress, heightInCm: heightInCm, weightInKg: weightInKg)
        do {
            let responseModel = try await insuracenContractRemoteDatasource.checkBMI(with: requestModel)
            return responseModel.isOk
        } catch EthereumClientError.executionError(let jsonRpcErrorDetail) {
            throw try jsonRpcErrorDetail.toCommonError()
        }
    }
    
    func checkHealthQuestions(with entity: HealthQuestionEntity) async throws -> Bool {
        let contractAdress = insuracenContractRemoteDatasource.getContractAdress()
        let requestModel = CheckHealthQuestionsRequestModel.fromEntity(contractAdress, with: entity)
        do {
            let responseModel = try await insuracenContractRemoteDatasource.checkHealthQuestions(with: requestModel)
            return responseModel.value
        } catch EthereumClientError.executionError(let jsonRpcErrorDetail) {
            throw try jsonRpcErrorDetail.toCommonError()
        }
    }
}

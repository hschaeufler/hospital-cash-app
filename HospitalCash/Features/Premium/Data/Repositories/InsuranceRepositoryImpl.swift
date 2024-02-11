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
    
    func calculatePremium(with: PremiumCalculationEntity) async throws -> Double {
        let contractAdress = insuracenContractRemoteDatasource.getContractAdress()
        let requestModel = GetPremiumRequestModel.fromEntity(with, contractAdress: contractAdress);
        do {
            let responseModel = try await insuracenContractRemoteDatasource
                .callSmartContract(with: requestModel)
            return responseModel.toEth()!
        } catch EthereumClientError.executionError(let jsonRpcErrorDetail) {
            throw try jsonRpcErrorDetail.toCommonError()
        }
    }
}

//
//  InsuranceRepositoryImpl.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 09.02.24.
//

import Foundation

class InsuranceRepositoryImpl: InsuranceRepository {
    let insuracenContractRemoteDatasource: InsuranceContractRemoteDatasource;
    
    init(insuracenContractRemoteDatasource: InsuranceContractRemoteDatasource) {
        self.insuracenContractRemoteDatasource = insuracenContractRemoteDatasource
    }
    
    func calculatePremium(
        ethAmount: Double,
        insuranceStartData: Date,
        birthDate: Date
    ) async throws -> Double {
        insuracenContractRemoteDatasource.callSmartContract()
    }
}

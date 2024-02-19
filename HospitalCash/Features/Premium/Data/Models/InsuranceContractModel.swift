//
//  InsuranceContractModel.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 18.02.24.
//

import Foundation
import BigInt
import web3

struct InsuranceContractModel: ABITuple {
    var encodableValues: [web3.ABIType] {
        [
            insuranceStartDate,
            insuranceEndDate,
            dailyHospitalCashImWei,
            policyId,
            birthDate
        ]
    }
    
    static var types: [ABIType.Type] {
        [
            BigUInt.self,
            BigUInt.self,
            BigUInt.self,
            BigUInt.self,
            BigInt.self
        ]
    }
    
    public let insuranceStartDate: BigUInt
    public let insuranceEndDate: BigUInt
    public let dailyHospitalCashImWei: BigUInt
    public let policyId: BigUInt
    public let birthDate: BigInt
    
    init(
        insuranceStartDate: BigUInt,
        insuranceEndDate: BigUInt,
        dailyHospitalCashImWei: BigUInt,
        policyId: BigUInt,
        birthDate: BigInt
    ) {
        self.insuranceStartDate = insuranceStartDate
        self.insuranceEndDate = insuranceEndDate
        self.dailyHospitalCashImWei = dailyHospitalCashImWei
        self.policyId = policyId
        self.birthDate = birthDate
    }
    
    init?(values: [web3.ABIDecoder.DecodedValue]) throws {
        self.insuranceStartDate = try values[0].decoded()
        self.insuranceEndDate = try values[1].decoded()
        self.dailyHospitalCashImWei = try values[2].decoded()
        self.policyId = try values[3].decoded()
        self.birthDate = try values[4].decoded()
    }
    
    public func encode(to encoder: web3.ABIFunctionEncoder) throws {
        try encoder.encode(insuranceStartDate)
        try encoder.encode(insuranceEndDate)
        try encoder.encode(dailyHospitalCashImWei)
        try encoder.encode(policyId)
        try encoder.encode(birthDate)
    }
}

extension InsuranceContractModel {
    func toEntity() -> InsuranceContractEntity {
       InsuranceContractEntity(
        insuranceStartDate: Date(timeIntervalSince1970: Double(String(self.insuranceStartDate))!),
        insuranceEndDate: Date(timeIntervalSince1970: Double(String(self.insuranceEndDate))!),
        dailyHospitalCash: Double(String(self.dailyHospitalCashImWei))! / Double(EthUnits.wei),
        policyId: Int(String(self.policyId))!,
        birthdate: Date(timeIntervalSince1970: Double(String(self.birthDate))!)
       )
    }
}

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
            dailyHospitalCashInWei,
            policyId,
            birthday
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
    public let dailyHospitalCashInWei: BigUInt
    public let policyId: BigUInt
    public let birthday: BigInt
    
    init(
        insuranceStartDate: BigUInt,
        insuranceEndDate: BigUInt,
        dailyHospitalCashInWei: BigUInt,
        policyId: BigUInt,
        birthday: BigInt
    ) {
        self.insuranceStartDate = insuranceStartDate
        self.insuranceEndDate = insuranceEndDate
        self.dailyHospitalCashInWei = dailyHospitalCashInWei
        self.policyId = policyId
        self.birthday = birthday
    }
    
    init?(values: [web3.ABIDecoder.DecodedValue]) throws {
        self.insuranceStartDate = try values[0].decoded()
        self.insuranceEndDate = try values[1].decoded()
        self.dailyHospitalCashInWei = try values[2].decoded()
        self.policyId = try values[3].decoded()
        self.birthday = try values[4].decoded()
    }
    
    public func encode(to encoder: web3.ABIFunctionEncoder) throws {
        try encoder.encode(insuranceStartDate)
        try encoder.encode(insuranceEndDate)
        try encoder.encode(dailyHospitalCashInWei)
        try encoder.encode(policyId)
        try encoder.encode(birthday)
    }
}

extension InsuranceContractModel {
    func toEntity() -> InsuranceContractEntity {
        print(self.insuranceStartDate)
        print(self.policyId)
        print(self.dailyHospitalCashInWei)
       return InsuranceContractEntity(
        insuranceStartDate: Date(timeIntervalSince1970: Double(String(self.insuranceStartDate))!),
        insuranceEndDate: Date(timeIntervalSince1970: Double(String(self.insuranceEndDate))!),
        dailyHospitalCash: Double(String(self.dailyHospitalCashInWei))! / Double(EthUnits.wei),
        policyId: Int(String(self.policyId))!,
        birthdate: Date(timeIntervalSince1970: Double(String(self.birthday))!)
       )
    }
}

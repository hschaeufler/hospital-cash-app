//
//  ContractModel.swift
//  HospitalCash
//
//  Created by hschaeufler on 18.02.24.
//

import Foundation
import BigInt
import web3

struct ContractModel: ABITuple {
    var encodableValues: [web3.ABIType] {
        [
            policyId,
            insuranceStartDate,
            insuranceEndDate,
            dailyHospitalCashInWei,
            paidPremiumInWei,
            lastPayOutDate,
            birthday
        ]
    }
    
    static var types: [ABIType.Type] {
        [
            BigUInt.self,
            BigUInt.self,
            BigUInt.self,
            BigUInt.self,
            BigUInt.self,
            BigUInt.self,
            BigInt.self
        ]
    }
    
    public let policyId: BigUInt
    public let insuranceStartDate: BigUInt
    public let insuranceEndDate: BigUInt
    public let dailyHospitalCashInWei: BigUInt
    public let paidPremiumInWei: BigUInt
    public let lastPayOutDate: BigUInt
    public let birthday: BigInt
    
    init(
        policyId: BigUInt,
        insuranceStartDate: BigUInt,
        insuranceEndDate: BigUInt,
        dailyHospitalCashInWei: BigUInt,
        paidPremiumInWei: BigUInt,
        lastPayOutDate: BigUInt,
        birthday: BigInt
    ) {
        self.policyId = policyId
        self.insuranceStartDate = insuranceStartDate
        self.insuranceEndDate = insuranceEndDate
        self.dailyHospitalCashInWei = dailyHospitalCashInWei
        self.paidPremiumInWei = paidPremiumInWei
        self.lastPayOutDate = lastPayOutDate
        self.birthday = birthday
    }
    
    init?(values: [web3.ABIDecoder.DecodedValue]) throws {
        self.policyId = try values[0].decoded()
        self.insuranceStartDate = try values[1].decoded()
        self.insuranceEndDate = try values[2].decoded()
        self.dailyHospitalCashInWei = try values[3].decoded()
        self.paidPremiumInWei = try values[4].decoded()
        self.lastPayOutDate = try values[5].decoded()
        self.birthday = try values[6].decoded()
    }
    
    public func encode(to encoder: web3.ABIFunctionEncoder) throws {
        try encoder.encode(policyId)
        try encoder.encode(insuranceStartDate)
        try encoder.encode(insuranceEndDate)
        try encoder.encode(dailyHospitalCashInWei)
        try encoder.encode(paidPremiumInWei)
        try encoder.encode(lastPayOutDate)
        try encoder.encode(birthday)
    }
}

extension ContractModel {
    func toEntity() -> ContractEntity {        
       return ContractEntity(
        policyId: Int(String(self.policyId))!,
        insuranceStartDate: self.insuranceStartDate.toDate(),
        insuranceEndDate: self.insuranceEndDate.toDate(),
        dailyHospitalCash: Double(String(self.dailyHospitalCashInWei))! / Double(EthUnits.wei),
        paidPremium: Double(String(self.paidPremiumInWei))! / Double(EthUnits.wei),
        lastPayoutDate: self.lastPayOutDate.toDate(),
        birthdate: self.birthday.toDate()
       )
    }
}

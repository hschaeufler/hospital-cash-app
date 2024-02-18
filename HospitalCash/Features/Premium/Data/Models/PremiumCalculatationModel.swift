//
//  PremiumCalculatationModel.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 18.02.24.
//

import Foundation
import BigInt
import web3

struct PremiumCalculatationModel: ABITuple {
    var encodableValues: [web3.ABIType] {
        [
            birthDate,
            insuranceStartDate,
            hospitalCashInWei
        ]
    }
    
    static var types: [ABIType.Type] {
        [
            BigInt.self,
            BigInt.self,
            BigUInt.self
        ]
    }
    
    public let birthDate: BigInt
    public let insuranceStartDate: BigInt
    public let hospitalCashInWei: BigUInt
    
    init(
        birthDate: BigInt,
        insuranceStartDate: BigInt,
        hospitalCashInWei: BigUInt
    ) {
        self.birthDate = birthDate
        self.insuranceStartDate = insuranceStartDate
        self.hospitalCashInWei = hospitalCashInWei
    }
    
    init?(values: [web3.ABIDecoder.DecodedValue]) throws {
        self.birthDate = try values[0].decoded()
        self.insuranceStartDate = try values[1].decoded()
        self.hospitalCashInWei = try values[2].decoded()
    }
    
    public func encode(to encoder: web3.ABIFunctionEncoder) throws {
        try encoder.encode(birthDate)
        try encoder.encode(insuranceStartDate)
        try encoder.encode(hospitalCashInWei)
    }
}

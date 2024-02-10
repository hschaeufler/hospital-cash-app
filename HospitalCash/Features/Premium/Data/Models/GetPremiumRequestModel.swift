//
//  GetHospitalCashPremiumModel.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 02.02.24.
//

import Foundation
import web3
import BigInt

struct GetPremiumRequestModel: ABIFunction {
    public static let name = "getHospitalCashPremium"
    public let gasPrice: BigUInt? = nil
    public let gasLimit: BigUInt? = nil
    public let contract: EthereumAddress
    public let from: EthereumAddress?=nil
    
    public let birthDate: BigUInt
    public let insuranceStartDate: BigUInt
    public let hospitalCashInWei: BigUInt
    
    init(_ contract: EthereumAddress,
         birthDateTs: BigUInt,
         insuranceStartDateTs: BigUInt,
         hospitalCashInWei: BigUInt
    ) {
        self.contract = contract
        self.birthDate = birthDateTs
        self.insuranceStartDate = insuranceStartDateTs
        self.hospitalCashInWei = hospitalCashInWei
    }
    
    public func encode(to encoder: web3.ABIFunctionEncoder) throws {
        try encoder.encode(birthDate)
        try encoder.encode(insuranceStartDate)
        try encoder.encode(hospitalCashInWei)
    }
}

extension GetPremiumRequestModel {
    static func fromEntity(
        _ entity: PremiumCalculationEntity,
        contractAdress: EthereumAddress
    ) -> GetPremiumRequestModel {
        let weiAmount = entity.amountHospitalCashEth * Double(EthUnits.wei)
        return GetPremiumRequestModel(
            contractAdress,
            birthDateTs: BigUInt(entity.birthDate.timeIntervalSince1970),
            insuranceStartDateTs: BigUInt(entity.insuranceDate.timeIntervalSince1970),
            hospitalCashInWei: BigUInt(weiAmount)
        )
    }
}


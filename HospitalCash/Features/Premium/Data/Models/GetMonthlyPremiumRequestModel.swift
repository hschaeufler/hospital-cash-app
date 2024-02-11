//
//  GetMonthlyPremiumRequestModel.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 02.02.24.
//

import Foundation
import web3
import BigInt

struct GetMonthlyPremiumRequestModel: ABIFunction {
    public static let name = "getMonthlyPremium"
    public let gasPrice: BigUInt? = nil
    public let gasLimit: BigUInt? = nil
    public let contract: EthereumAddress
    public let from: EthereumAddress?=nil
    
    public let birthDate: BigInt
    public let insuranceStartDate: BigInt
    public let hospitalCashInWei: BigUInt
    
    init(_ contract: EthereumAddress,
         birthDateTs: BigInt,
         insuranceStartDateTs: BigInt,
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

extension GetMonthlyPremiumRequestModel {
    static func fromEntity(
        _ contractAdress: EthereumAddress,
        with entity: PremiumCalculationEntity
    ) -> GetMonthlyPremiumRequestModel {
        let weiAmount = entity.amountHospitalCashEth * Double(EthUnits.wei)
        return GetMonthlyPremiumRequestModel(
            contractAdress,
            birthDateTs: BigInt(entity.birthDate.timeIntervalSince1970),
            insuranceStartDateTs: BigInt(entity.insuranceDate.timeIntervalSince1970),
            hospitalCashInWei: BigUInt(weiAmount)
        )
    }
}


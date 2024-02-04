//
//  GetHospitalCashPremiumModel.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 02.02.24.
//

import Foundation
import web3
import BigInt

struct GetHospitalCashPremiumModel: ABIFunction {
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

extension GetHospitalCashPremiumModel {
    func toHexString() -> String {
        let transaction = try? self.transaction()
        return transaction?.data?.web3.hexString ?? ""
    }
}

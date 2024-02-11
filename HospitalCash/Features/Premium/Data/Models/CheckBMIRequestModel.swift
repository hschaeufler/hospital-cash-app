//
//  CheckBMIRequestModel.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 11.02.24.
//

import Foundation
import web3
import BigInt

struct CheckBMIRequestModel: ABIFunction {
    public static let name = "checkBMI"
    public let gasPrice: BigUInt? = nil
    public let gasLimit: BigUInt? = nil
    public let contract: EthereumAddress
    public let from: EthereumAddress?=nil
    
    public let heightInCm: BigUInt
    public let weightInKg: BigUInt
    
    init(_ contract: EthereumAddress,
         heightInCm: BigUInt,
         weightInKg: BigUInt
    ) {
        self.contract = contract
        self.heightInCm = heightInCm
        self.weightInKg = weightInKg
    }
    
    public func encode(to encoder: web3.ABIFunctionEncoder) throws {
        try encoder.encode(heightInCm)
        try encoder.encode(weightInKg)
    }
}

extension CheckBMIRequestModel {
    static func fromEntity(
        _ contractAdress: EthereumAddress,
        heightInCm: Int,
        weightInKg: Int
    ) -> CheckBMIRequestModel {
        CheckBMIRequestModel(
            contractAdress,
            heightInCm: BigUInt(heightInCm),
            weightInKg: BigUInt(weightInKg)
        )
    }
}


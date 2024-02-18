//
//  ContractApplicationModel.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 18.02.24.
//

import Foundation
import web3

struct ContractApplicationModel: ABITuple {
    var encodableValues: [web3.ABIType] {
        [
            heightInCm,
            weightInKg
        ]
    }
    
    static var types: [ABIType.Type] {
        [
            BigUInt.self,
            BigUInt.self
        ]
    }
    
    public let heightInCm: BigUInt
    public let weightInKg: BigUInt
    
    init(
        heightInCm: BigUInt,
        weightInKg: BigUInt
    ) {
        self.heightInCm = heightInCm
        self.weightInKg = weightInKg
    }
    
    init?(values: [web3.ABIDecoder.DecodedValue]) throws {
        self.heightInCm = try values[0].decoded()
        self.weightInKg = try values[1].decoded()
    }
    
    public func encode(to encoder: web3.ABIFunctionEncoder) throws {
        try encoder.encode(heightInCm)
        try encoder.encode(weightInKg)
    }
}

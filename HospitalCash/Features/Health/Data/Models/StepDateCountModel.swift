//
//  StepDateCountModel.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 24.02.24.
//

import Foundation

import Foundation
import BigInt
import web3

struct StepDateCountModel: ABITuple {
    var encodableValues: [web3.ABIType] {
        [
            date,
            steps
        ]
    }
    
    static var types: [ABIType.Type] {
        [
            BigUInt.self,
            BigUInt.self
        ]
    }
    
    public let date: BigUInt
    public let steps: BigUInt
    
    init(
        date: BigUInt,
        steps: BigUInt
    ) {
        self.date = date
        self.steps = steps
    }
    
    init?(values: [web3.ABIDecoder.DecodedValue]) throws {
        self.date = try values[0].decoded()
        self.steps = try values[1].decoded()
    }
    
    public func encode(to encoder: web3.ABIFunctionEncoder) throws {
        try encoder.encode(date)
        try encoder.encode(steps)
    }
}

extension StepDateCountModel {
    static func fromEntity(
        with entity: StepDateCountEntity
    ) throws -> StepDateCountModel {
        return StepDateCountModel(
            date: BigUInt(entity.date.timeIntervalSince1970),
            steps: BigUInt(entity.steps)
        )
    }
}

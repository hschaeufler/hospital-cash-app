//
//  ContractApplicationModel.swift
//  HospitalCash
//
//  Created by hschaeufler on 18.02.24.
//

import Foundation
import web3
import BigInt

struct ContractApplicationModel: ABITuple {
    var encodableValues: [web3.ABIType] {
        [
            healthQuestions,
            premiumCalculation,
            bodyMeasure
        ]
    }
    
    static var types: [ABIType.Type] {
        [
            HealthQuestionModel.self,
            PremiumCalculationModel.self,
            BodyMeasureModel.self
        ]
    }
    
    public let healthQuestions: HealthQuestionModel
    public let premiumCalculation: PremiumCalculationModel
    public let bodyMeasure: BodyMeasureModel
    
    init(
        healthQuestions: HealthQuestionModel,
        premiumCalculation: PremiumCalculationModel,
        bodyMeasure: BodyMeasureModel
    ) {
        self.healthQuestions = healthQuestions
        self.premiumCalculation = premiumCalculation
        self.bodyMeasure = bodyMeasure
    }
    
    init?(values: [web3.ABIDecoder.DecodedValue]) throws {
        self.healthQuestions = try values[0].decoded()
        self.premiumCalculation = try values[1].decoded()
        self.bodyMeasure = try values[2].decoded()
    }
    
    public func encode(to encoder: web3.ABIFunctionEncoder) throws {
        try encoder.encode(healthQuestions)
        try encoder.encode(premiumCalculation)
        try encoder.encode(bodyMeasure)
    }
}


extension ContractApplicationModel {
    static func fromEntity(
        with entity: ContractApplicationEntity
    ) -> ContractApplicationModel {
        ContractApplicationModel(
            healthQuestions: HealthQuestionModel.fromEntity(with: entity.healthQuestions),
            premiumCalculation: PremiumCalculationModel.fromEntity(with: entity.premiumCalculation),
            bodyMeasure: BodyMeasureModel.fromEntity(with: entity.bodyMeasure)
        )
    }
}

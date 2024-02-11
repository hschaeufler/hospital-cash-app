//
//  HealthQuestionModel.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 11.02.24.
//

import Foundation
import web3
import BigInt

struct HealthQuestionModel: ABITuple {
    var encodableValues: [web3.ABIType] {
        [
            hasNoInpatientTreatment,
            hasNoOutpatientTreatment,
            hasNoPsychotherapy,
            hasNoChronicIllness,
            hasNoMedication
        ]
    }
    
    static var types: [ABIType.Type] {
        [Bool.self, Bool.self, Bool.self, Bool.self, Bool.self]
    }
    
    public let hasNoInpatientTreatment: Bool
    public let hasNoOutpatientTreatment: Bool
    public let hasNoPsychotherapy: Bool
    public let hasNoChronicIllness: Bool
    public let hasNoMedication: Bool
    
    init(
        hasNoInpatientTreatment: Bool,
        hasNoOutpatientTreatment: Bool,
        hasNoPsychotherapy: Bool,
        hasNoChronicIllness: Bool,
        hasNoMedication: Bool
    ) {
        self.hasNoInpatientTreatment = hasNoInpatientTreatment
        self.hasNoOutpatientTreatment = hasNoOutpatientTreatment
        self.hasNoPsychotherapy = hasNoPsychotherapy
        self.hasNoChronicIllness = hasNoChronicIllness
        self.hasNoMedication = hasNoMedication
    }
    
    init?(values: [web3.ABIDecoder.DecodedValue]) throws {
        self.hasNoInpatientTreatment = try values[0].decoded()
        self.hasNoOutpatientTreatment = try values[1].decoded()
        self.hasNoPsychotherapy = try values[2].decoded()
        self.hasNoChronicIllness = try values[3].decoded()
        self.hasNoMedication = try values[4].decoded()
    }
    
    public func encode(to encoder: web3.ABIFunctionEncoder) throws {
        try encoder.encode(hasNoInpatientTreatment)
        try encoder.encode(hasNoOutpatientTreatment)
        try encoder.encode(hasNoPsychotherapy)
        try encoder.encode(hasNoChronicIllness)
        try encoder.encode(hasNoMedication)
    }
}

extension HealthQuestionModel {
    static func fromEntity(with entity: HealthQuestionEntity) -> HealthQuestionModel {
        HealthQuestionModel(
            hasNoInpatientTreatment: entity.hasNoInpatientTreatment,
            hasNoOutpatientTreatment: entity.hasNoOutpatientTreatment,
            hasNoPsychotherapy: entity.hasNoPsychotherapy,
            hasNoChronicIllness: entity.hasNoChronicIllness,
            hasNoMedication: entity.hasNoMedication
        )
    }
}

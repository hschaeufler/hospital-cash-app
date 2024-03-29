//
//  HealthQuestionModel.swift
//  HospitalCash
//
//  Created by hschaeufler on 28.01.24.
//

import Foundation

struct HealthQuestionEntity: Equatable {
    var hasNoInpatientTreatment: Bool
    var hasNoOutpatientTreatment: Bool
    var hasNoPsychotherapy: Bool
    var hasNoChronicIllness: Bool
    var hasNoMedication: Bool
}


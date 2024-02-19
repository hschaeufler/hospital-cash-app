//
//  ContractApplication.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 17.02.24.
//

import Foundation

struct ContractApplicationEntity {
    var healthQuestions: HealthQuestionEntity
    var premiumCalculation: PremiumCalculationEntity
    var bodyMeasure: BodyMeasureEntity
    var yearlyPremiumInEth: Double
}

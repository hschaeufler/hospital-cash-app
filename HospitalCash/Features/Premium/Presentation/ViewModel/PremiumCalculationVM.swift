//
//  PremiumCalculationViewModel.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 31.01.24.
//
import Factory
import SwiftUI

@Observable class PremiumCalculationVM {
    @ObservationIgnored
    @Injected(\PremiumContainer.calculateBMI) private var calculateBMI
    
    var height = 175
    var weight = 80
    var healthQuestions = HealthQuestionEntity(
        hasNoInpatientTreatment: false,
        hasNoOutpatientTreatment: false,
        hasNoPsychotherapy: false,
        hasNoChronicIllness: false,
        hasNoMedication: false
    )
    
    var bmi: Double {
        calculateBMI(height: height, weight: weight)
    }
    
}

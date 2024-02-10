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
    @ObservationIgnored
    @Injected(\PremiumContainer.checkHealthQuestionValidity) private var checkHealthQuestionValidityUseCase
    @ObservationIgnored
    @Injected(\PremiumContainer.calculateEthInEur) private var calculateEthInEurUseCase
    @ObservationIgnored
    @Injected(\PremiumContainer.calculateEurInEth) private var calculateEurInEthUseCase
    @ObservationIgnored
    @Injected(\PremiumContainer.calculatePremium) private var calculatePremiumUseCase
    
    var error: Error?
    
    var height = 175
    var weight = 80
    var bmi: Double {
        calculateBMI(height: height, weight: weight)
    }
    
    var healthQuestions = HealthQuestionEntity(
        hasNoInpatientTreatment: false,
        hasNoOutpatientTreatment: false,
        hasNoPsychotherapy: false,
        hasNoChronicIllness: false,
        hasNoMedication: false
    )
    
    var areHealthQuestionsValid: Bool {
        checkHealthQuestionValidityUseCase(with: healthQuestions)
    }
    
    var amountHospitalCashEur = 0
    var amountHospitalCashEth = 0.0
    var calculatedPremium: PremiumEntity? = nil
    var insuranceDate = Date()
    var birthDate = Date()
    
    func calculateEurInEth() async {
        do {
            let amount = Double(amountHospitalCashEur)
            amountHospitalCashEth = try await calculateEurInEthUseCase(euroAmount: amount)
        } catch {
            self.error = error
        }
    }
    
    func caculatePremium() async {
        do {
            let premiumCalculationEntity = PremiumCalculationEntity(
                amountHospitalCashEth: self.amountHospitalCashEth,
                insuranceDate: self.insuranceDate,
                birthDate: self.birthDate
            )
            self.calculatedPremium = try await calculatePremiumUseCase(with: premiumCalculationEntity)
        } catch {
            self.error = error
        }
    }
}

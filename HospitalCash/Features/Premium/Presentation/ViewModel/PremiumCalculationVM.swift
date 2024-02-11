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
    @Injected(\PremiumContainer.calculateBMI) private var calculateBMIUseCase
    @ObservationIgnored
    @Injected(\PremiumContainer.checkBMI) private var checkBMIUseCase
    @ObservationIgnored
    @Injected(\PremiumContainer.checkHealthQuestionValidity) private var checkHealthQuestionValidityUseCase
    @ObservationIgnored
    @Injected(\PremiumContainer.calculateEthInEur) private var calculateEthInEurUseCase
    @ObservationIgnored
    @Injected(\PremiumContainer.calculateEurInEth) private var calculateEurInEthUseCase
    @ObservationIgnored
    @Injected(\PremiumContainer.calculatePremium) private var calculatePremiumUseCase
    
    var path: [NavigationDestination] = []
    
    var error: Error?
    var showError: Bool {
        get {
            error != nil
        }
        set {
            error = nil
        }
    }
    
    var height = 175
    var weight = 80
    var bmiIsOk = false;
    
    var bmi: Double {
        calculateBMIUseCase(height: height, weight: weight)
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
    var premiumEntity: PremiumEntity? = nil
    
    var fromTomorrowRange: PartialRangeFrom<Date> {
        Calendar.current.date(
            byAdding: .day,
            value: 1,
            to: Date.now
        )!...
    }
    var untilYesterdayRange: PartialRangeThrough<Date> {
        ...Calendar.current.date(
            byAdding: .day,
            value: -1,
            to: Date.now
        )!
    }
    var insuranceStartDate = Date()
    var birthDate = Date()
    
    var isCalculationAllowed: Bool {
        amountHospitalCashEth != 0
    }
    
    func checkBMI() async {
        do {
            self.bmiIsOk = try await checkBMIUseCase(heightInCm: height, weightInKg: weight)
            self.navigate(to: .healthQuestions)
        } catch {
            self.error = error
        }
    }
    
    func calculateEurInEth() async {
        do {
            let amount = Double(amountHospitalCashEur)
            amountHospitalCashEth = try await calculateEurInEthUseCase(euroAmount: amount)
        } catch {
            self.error = error
        }
    }
    
    func navigate(to destination: NavigationDestination) {
        self.path.append(destination)
    }
    
    func caculatePremium() async {
        do {
            let premiumCalculationEntity = PremiumCalculationEntity(
                amountHospitalCashEth: self.amountHospitalCashEth,
                insuranceDate: self.insuranceStartDate,
                birthDate: self.birthDate
            )
            self.premiumEntity = try await calculatePremiumUseCase(with: premiumCalculationEntity)
            self.navigate(to: .premiumDetail)
        } catch {
            self.error = error
        }
    }
}

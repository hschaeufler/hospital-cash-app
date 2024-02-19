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
    @ObservationIgnored
    @Injected(\PremiumContainer.underwriteContract) private var underwriteContractUseCase
    
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
    var areHealthQuestionsValid = false
    
    var amountHospitalCashEur = 0
    var amountHospitalCashEth = 0.0
    var premiumEntity: PremiumEntity? = nil
    
    var fromTomorrowRange: ClosedRange<Date> {
        Calendar.current.date(
            byAdding: .day,
            value: 1,
            to: Date.now
        )!...Calendar.current.date(
            byAdding: .month,
            value: 6,
            to: Date.now
        )!
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
    
    var showPaymentSheet = false;
    
    var insuranceContract: InsuranceContractEntity? = nil
    
    func checkBMI() async {
        do {
            self.bmiIsOk = try await checkBMIUseCase(heightInCm: height, weightInKg: weight)
            self.navigate(to: .healthQuestions)
        } catch {
            self.error = error
        }
    }
    
    func checkHealthQuestions() async {
        do {
            self.areHealthQuestionsValid = false;
            self.areHealthQuestionsValid = try await checkHealthQuestionValidityUseCase(with: healthQuestions)
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
    
    func pop() {
        self.path.removeLast()
    }
    
    func caculatePremium() async {
        do {
            let premiumCalculationEntity = PremiumCalculationEntity(
                amountHospitalCashEth: self.amountHospitalCashEth,
                insuranceStartDate: self.insuranceStartDate,
                birthDate: self.birthDate
            )
            self.premiumEntity = try await calculatePremiumUseCase(with: premiumCalculationEntity)
            self.navigate(to: .premiumDetail)
        } catch {
            self.error = error
        }
    }
    
    func underwriteContract() async {
        do {
            let application = ContractApplicationEntity(
                healthQuestions: healthQuestions, 
                premiumCalculation: PremiumCalculationEntity(
                    amountHospitalCashEth: self.amountHospitalCashEth,
                    insuranceStartDate: self.insuranceStartDate,
                    birthDate: self.birthDate
                ), 
                bodyMeasure: BodyMeasureEntity(
                    heightInCm: self.height,
                    weightInKg: self.weight
                ),
                yearlyPremiumInEth: self.premiumEntity!.yearlyEthPremium
            )
            self.insuranceContract = try await underwriteContractUseCase(with: application)
            self.showPaymentSheet = false;
            self.navigate(to: .contractDetail)
        } catch {
            self.showPaymentSheet = false;
            print(error.localizedDescription)
            self.error = error
        }
    }
}

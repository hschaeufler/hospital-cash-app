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
    @Injected(\PremiumContainer.connectWallet) private var connectWalletUseCase
    @ObservationIgnored
    @Injected(\PremiumContainer.underwriteContract) private var underwriteContractUseCase
    @ObservationIgnored
    @Injected(\PremiumContainer.getTransactionState) private var getTransactionStateUseCase
    @ObservationIgnored
    @Injected(\PremiumContainer.getContrat) private var getContractUseCase
    
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
    
    var showConnectSheet = false;
    var showPaymentSheet = false;
    
    var tx: String? = nil
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
    
    func navigateWithReplace(to destination: NavigationDestination) {
        self.path.removeAll()
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
    
    func connectWallet() async {
        do {
            let _ = try await self.connectWalletUseCase();
            self.showConnectSheet = false;
            self.showPaymentSheet = true;
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
            self.tx = try await underwriteContractUseCase(with: application)
            
            self.navigateWithReplace(to: .contractDetail)
            self.showPaymentSheet = false;
        } catch {
            self.showPaymentSheet = false;
            self.error = error
        }
    }
    
    func getContractStatus() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            Task {
                do {
                    guard self.insuranceContract == nil else {
                        return
                    }
                    
                    let transactionStatus = try await self.getTransactionStateUseCase(with: self.tx!)
                    switch transactionStatus {
                    case .failure:
                        throw CommonError.contractExecutionError(message: "Transaction fehlerhaft")
                    case .success:
                        self.insuranceContract = try await self.getContractUseCase()
                        self.getContractStatus()
                        break
                    case .notProcessed:
                        self.getContractStatus()
                        break
                    }
                } catch {
                    print(error)
                    self.error = error
                }
            }
            
        }
    }
}

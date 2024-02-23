//
//  UnderwritingVM.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 31.01.24.
//
import Factory
import SwiftUI

@Observable class UnderwritingViewModel {
    @ObservationIgnored
    @Injected(\UnderwritingContainer.calculateBMI) private var calculateBMIUseCase
    @ObservationIgnored
    @Injected(\UnderwritingContainer.checkBMI) private var checkBMIUseCase
    @ObservationIgnored
    @Injected(\UnderwritingContainer.checkHealthQuestionValidity) private var checkHealthQuestionValidityUseCase
    @ObservationIgnored
    @Injected(\UnderwritingContainer.calculateEthInEur) private var calculateEthInEurUseCase
    @ObservationIgnored
    @Injected(\UnderwritingContainer.calculateEurInEth) private var calculateEurInEthUseCase
    @ObservationIgnored
    @Injected(\UnderwritingContainer.calculatePremium) private var calculatePremiumUseCase
    @ObservationIgnored
    @Injected(\OnboardingContainer.connectWallet) private var connectWalletUseCase
    @ObservationIgnored
    @Injected(\UnderwritingContainer.underwriteContract) private var underwriteContractUseCase
    @ObservationIgnored
    @Injected(\UnderwritingContainer.getContractByTransaction) private var getContractByTransactionUseCase
    @ObservationIgnored
    @Injected(\OnboardingContainer.getAppState) private var getAppState
    
    enum Destination {
        case bmi,
             healthQuestions,
             premiumCalculation,
             premiumDetail,
             contractDetail,
             alreadyInsured
    }
    
    var path: [Destination] = []
    
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
        DateUtils.tommorow()...Calendar.current.date(
            byAdding: .month,
            value: 6,
            to: Date.now
        )!
    }
    var untilYesterdayRange: PartialRangeThrough<Date> {
        ...DateUtils.yesterday()
    }
    
    var insuranceStartDate = DateUtils.tommorow()
    var birthDate = DateUtils.yesterday()
    
    var isCalculationAllowed: Bool {
        amountHospitalCashEth != 0
    }
    
    var showConnectSheet = false;
    var showPaymentSheet = false;
    
    var tx: String? = nil
    var insuranceContract: ContractEntity? = nil
    
    func navigate(to destination: Destination) {
        self.path.append(destination)
    }
    
    func navigateWithReplace(to destination: Destination) {
        self.path.removeAll()
        self.path.append(destination)
    }
    
    func pop() {
        self.path.removeLast()
    }
    
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
    
    private func handleGetAppstate() async throws {
        let appState = try await self.getAppState()
        switch appState {
        case .initial:
            self.showConnectSheet = true;
            self.showPaymentSheet = false;
            break
        case .isConnected:
            self.showConnectSheet = false;
            self.showPaymentSheet = true;
            break
        case .hasContract:
            self.navigateWithReplace(to: .alreadyInsured)
            break
        }
    }
    
    func handleShowWallet() async {
        do {
            try await handleGetAppstate();
        } catch {
            self.error = error
        }
    }
    
    func handleConnectWallet() async {
        do {
            let _ = try await self.connectWalletUseCase();
            try await handleGetAppstate();
        } catch {
            self.error = error
        }
    }
    
    func handleUnderwriteContract() async {
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
    
    func fetchContract() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            Task {
                do {
                    self.insuranceContract = try await self.getContractByTransactionUseCase(with: self.tx!);
                    if(self.insuranceContract == nil) {
                        self.fetchContract()
                    }
                } catch {
                    print(error)
                    self.error = error
                }
            }
            
        }
    }
}

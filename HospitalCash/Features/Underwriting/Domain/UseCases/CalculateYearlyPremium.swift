//
//  CalculatePremium.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 09.02.24.
//

import Foundation

protocol CalculateYearlyPremium {
    func callAsFunction(with premiumCalculation: PremiumCalculationEntity) async throws -> PremiumEntity
}

struct CalculatePremiumUseCase: CalculateYearlyPremium {
    private let insuranceRepository: ContractRepository
    private let calculateEthInEur: CalculateEthInEur
    
    init(
        insuranceRepository: ContractRepository,
        calculateEthInEur: CalculateEthInEur
    ) {
        self.insuranceRepository = insuranceRepository
        self.calculateEthInEur = calculateEthInEur
    }
 
    func callAsFunction(with premiumCalculation: PremiumCalculationEntity) async throws -> PremiumEntity {
        let monthlyEthPremium = try await insuranceRepository.getMonthlyPremium(with: premiumCalculation)
        let yearlyEthPremium = monthlyEthPremium * 12
        let yearlyEurPremium = try await calculateEthInEur(ethAmount: yearlyEthPremium)
        return PremiumEntity(
            yearlyEthPremium: yearlyEthPremium,
            yearlyEurPremium: yearlyEurPremium
        )
    }
}

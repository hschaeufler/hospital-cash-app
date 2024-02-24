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
    private let premiumRepository: PremiumRepository
    private let calculateEthInEur: CalculateEthInEur
    
    init(
        premiumRepository: PremiumRepository,
        calculateEthInEur: CalculateEthInEur
    ) {
        self.premiumRepository = premiumRepository
        self.calculateEthInEur = calculateEthInEur
    }
 
    func callAsFunction(with premiumCalculation: PremiumCalculationEntity) async throws -> PremiumEntity {
        let monthlyEthPremium = try await premiumRepository.getMonthlyPremium(with: premiumCalculation)
        // Add 10 Weis to to avoid rounding errors.
        let yearlyEthPremium = monthlyEthPremium * 12 + Double(10 / EthUnits.wei)
        let yearlyEurPremium = try await calculateEthInEur(ethAmount: yearlyEthPremium)
        return PremiumEntity(
            yearlyEthPremium: yearlyEthPremium,
            yearlyEurPremium: yearlyEurPremium
        )
    }
}

//
//  CalculateEthInEur.swift
//  HospitalCash
//
//  Created by hschaeufler on 31.01.24.
//

import Foundation

protocol CalculateEthInEur {
    func callAsFunction(ethAmount: Double) async throws -> Double
}

struct CalculateEthInEurUseCase: CalculateEthInEur {
    private let exchangeRateRepository: ExchangeRateRepository
    
    init(exchangeRateRepository: ExchangeRateRepository) {
        self.exchangeRateRepository = exchangeRateRepository
    }
 
    func callAsFunction(ethAmount: Double) async throws -> Double {
        let ethEurPrice = try await exchangeRateRepository.getEthEurPrice()
        return ethAmount * ethEurPrice
    }
}

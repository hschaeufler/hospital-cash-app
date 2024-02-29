//
//  CalculateEurInEth.swift
//  HospitalCash
//
//  Created by hschaeufler on 31.01.24.
//

import Foundation


protocol CalculateEurInEth {
    func callAsFunction(euroAmount: Double) async throws -> Double
}

struct CalculateEurInEthUseCase: CalculateEurInEth {
    private let exchangeRateRepository: ExchangeRateRepository
    
    init(exchangeRateRepository: ExchangeRateRepository) {
        self.exchangeRateRepository = exchangeRateRepository
    }
 
    func callAsFunction(euroAmount: Double) async throws -> Double {
        let eurEthPrice = try await exchangeRateRepository.getEurEthPrice()
        return euroAmount * eurEthPrice
    }
}

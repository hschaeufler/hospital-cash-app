//
//  ExchangeRateRepository.swift
//  HospitalCash
//
//  Created by hschaeufler on 31.01.24.
//

import Foundation

protocol ExchangeRateRepository {
    func getEthEurPrice() async throws -> Double
    func getEurEthPrice() async throws -> Double
}

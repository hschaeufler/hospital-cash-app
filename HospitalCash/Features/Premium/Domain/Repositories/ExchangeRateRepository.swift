//
//  ExchangeRateRepository.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 31.01.24.
//

import Foundation

protocol ExchangeRateRepository {
    func getEthInEur() async throws -> Double
    func getEurInEth() async throws -> Double
}

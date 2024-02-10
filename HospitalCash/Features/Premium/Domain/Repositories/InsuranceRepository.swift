//
//  InsuranceRepository.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 09.02.24.
//

import Foundation

protocol InsuranceRepository {
    func calculatePremium(with: PremiumCalculationEntity) async throws -> Double
}

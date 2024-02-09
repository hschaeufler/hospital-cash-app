//
//  InsuranceRepository.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 09.02.24.
//

import Foundation

protocol InsuranceRepository {
    func calculatePremium(
        ethAmount: Double,
        isuranceStartData: Date,
        birthDate: Date
    ) async throws -> Double
}

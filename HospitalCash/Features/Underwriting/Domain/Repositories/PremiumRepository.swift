//
//  PremiumRepository.swift
//  HospitalCash
//
//  Created by hschaeufler on 23.02.24.
//

import Foundation

protocol PremiumRepository {
    func getMonthlyPremium(with entity: PremiumCalculationEntity) async throws -> Double
    func checkBMI(heightInCm: Int, weightInKg: Int) async throws -> Bool
    func checkHealthQuestions(with entity: HealthQuestionEntity) async throws -> Bool
}

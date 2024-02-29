//
//  HealthRepositories.swift
//  HospitalCash
//
//  Created by hschaeufler on 23.02.24.
//

import Foundation

protocol HealthRepository {
    func getTodayStepCount() async throws -> Double?
    func getWeeklySteps() async throws -> [StepDateCountEntity]
    func getLastPayoutDate() async throws -> Date
    func claimDiscount(with weeklyStepCount: [StepDateCountEntity]) async throws -> String
}

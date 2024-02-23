//
//  HealthRepositories.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import Foundation

protocol HealthRepository {
    func getTodayStepCount() async throws -> Double?
}

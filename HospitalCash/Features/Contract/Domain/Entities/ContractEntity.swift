//
//  ContractEntity.swift
//  HospitalCash
//
//  Created by hschaeufler on 17.02.24.
//

import Foundation

struct ContractEntity {
    let policyId: Int
    let insuranceStartDate: Date
    let insuranceEndDate: Date
    let dailyHospitalCash: Double
    let paidPremium: Double
    let lastPayoutDate: Date
    let birthdate: Date
}

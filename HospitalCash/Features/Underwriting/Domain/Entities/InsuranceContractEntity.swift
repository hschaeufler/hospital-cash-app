//
//  InsuranceContractEntity.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 17.02.24.
//

import Foundation

struct InsuranceContractEntity {
    let policyId: Int
    let insuranceStartDate: Date
    let insuranceEndDate: Date
    let dailyHospitalCash: Double
    let birthdate: Date
}

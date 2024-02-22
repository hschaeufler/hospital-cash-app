//
//  NewContractEventEntity.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 21.02.24.
//

import Foundation

struct NewContractEventEntity {
    let policyId: Int
    let insuranceStartDate: Date
    let insuranceEndDate: Date
    let dailyHospitalCash: Double
}

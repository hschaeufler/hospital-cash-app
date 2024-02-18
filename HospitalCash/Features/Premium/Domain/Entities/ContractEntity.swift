//
//  InsuranceContractEntity.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 17.02.24.
//

import Foundation

struct ContractEntity {
    let insuranceStartDate: Date;
    let insuranceEndDate: Date;
    let dailyHospitalCash: Double;
    let policyId: Int;
    let birthdate: Date;
}

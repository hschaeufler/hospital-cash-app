//
//  ContractDetailLayout.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import SwiftUI

struct ContractDetailLayout: View {
    var contract: ContractEntity
    
    var body: some View {
        Group {
            HStack {
                Avatar(systemName: "newspaper")
                Spacer()
            }
            .padding(.leading)
            ContractDetailGroup(
                insuranceContract: contract
            )
        }
    }
}

#Preview {
    let contractEntity = ContractEntity(
        policyId: 1,
        insuranceStartDate: Date(),
        insuranceEndDate: Date(),
        dailyHospitalCash: 0.5,
        birthdate: Date()
    );
    return ContractDetailLayout(contract: contractEntity)
}

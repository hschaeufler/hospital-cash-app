//
//  ContractViewState.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import SwiftUI

struct ContractStateView: View {
    var viewState: ContractViewModel.ContractViewState
    
    var body: some View {
        switch viewState {
        case .loading:
            ProgressView()
        case .loaded(let contractEntity):
            ContractDetailLayout(contract: contractEntity)
        case .error(let errorMessage):
            Text(errorMessage)
        }
    }
}

#Preview {
    let contractEntity = ContractEntity(
        policyId: 1,
        insuranceStartDate: Date(),
        insuranceEndDate: Date(),
        dailyHospitalCash: 0.5,
        paidPremium: 0.5,
        lastPayoutDate: Date(),
        birthdate: Date()
    );
    return ContractStateView(viewState: .loaded(contractEntity))
}

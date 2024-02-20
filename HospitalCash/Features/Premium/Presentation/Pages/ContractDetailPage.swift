//
//  ContractDetailPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 19.02.24.
//

import SwiftUI

struct ContractDetailPage: View {
    @Environment(PremiumCalculationVM.self) private var viewModel
    
    var body: some View {
        SheetPageLayout("Deine Versicherung") {
            VStack {
                Spacer()
                Image(systemName: "fireworks")
                    .font(.system(size: 90))
                    .foregroundStyle(.green, .blue)
                Text("Gratulation zum \nerfolgreichen Abschluss!")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .bold()
                CustomDivider(maxWidth: 150)
                    .padding(.vertical, 10)
                ContractDetailGroup(insuranceContract: viewModel.insuranceContract!)
                Spacer()
                BorderedButton("Zur Übersicht") {}
            }
        }
    }
}

#Preview {
    let viewModel = PremiumCalculationVM()
    viewModel.insuranceContract = InsuranceContractEntity(
        insuranceStartDate: Date(),
        insuranceEndDate: Date(),
        dailyHospitalCash: 100,
        policyId: 1,
        birthdate: Date()
    );
    
    return ContractDetailPage()
        .environment(viewModel)
}

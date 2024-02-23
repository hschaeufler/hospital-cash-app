//
//  ContractDetailPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 19.02.24.
//

import SwiftUI

struct ContractDetailPage: View {
    @Environment(UnderwritingViewModel.self) private var underwritingVM
    @Environment(WalletViewModel.self) private var walletVM

    
    var body: some View {
        UnderwritingSheetLayout("Deine Versicherung") {
            VStack {
                Image(systemName: "fireworks")
                    .font(.system(size: 90))
                    .foregroundStyle(.green, .blue)
                Text("Gratulation zum \nerfolgreichen Abschluss!")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .bold()
                CustomDivider(maxWidth: 150)
                    .padding(.vertical, 10)
                if let insuranceContract = underwritingVM.insuranceContract {
                    ContractDetailGroup(insuranceContract: insuranceContract)
                } else {
                    Spacer()
                    ProgressView()
                }
                Spacer()
                BorderedButton("Zur Übersicht") {
                    Task {
                        await walletVM.fetchAppState()
                    }
                }
            }
        }
        .onAppear {
            underwritingVM.fetchContract()
        }
    }
}

#Preview {
    let viewModel = UnderwritingViewModel()
    viewModel.insuranceContract = ContractEntity(
        policyId: 1,
        insuranceStartDate: Date(),
        insuranceEndDate: Date(),
        dailyHospitalCash: 100,
        birthdate: Date()
    );
    
    return ContractDetailPage()
        .environment(viewModel)
        .environment(WalletViewModel())
}

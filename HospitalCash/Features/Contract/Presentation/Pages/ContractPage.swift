//
//  ContractPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import SwiftUI

struct ContractPage: View {
    @State private var contractVM = ContractViewModel()
    @Environment(WalletViewModel.self) private var walletVM
    
    var body: some View {
        NavigationStack {
            ContractStateView(viewState: contractVM.state)
                .navigationTitle("Vertragsdetails")
                .toolbar {
                    Button {
                        walletVM.handleLogout()
                    } label: {
                        Label("Logout", systemImage: "xmark.circle")
                    }
                }
                .onAppear {
                    Task {
                        await contractVM.fetchContract()
                    }
                }
        }
    }
}

#Preview {
    ContractPage()
        .environment(WalletViewModel())
}

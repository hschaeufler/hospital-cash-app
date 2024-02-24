//
//  HealthPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import SwiftUI

struct HealthPage: View {
    @Environment(WalletViewModel.self) private var walletVM
    
    var body: some View {
        NavigationStack {
            List {
                    DailyStepsStateView()
                        .listRowInsets(EdgeInsets())
                    WeeklyStepsStateView()
                        .listRowInsets(EdgeInsets())
            }
            .listRowSpacing(15)
            .listRowInsets(.none)
            .navigationTitle("Gesundheit")
            .toolbar {
                Button {
                    walletVM.handleLogout()
                } label: {
                    Label("Logout", systemImage: "xmark.circle")
                }
            }
        }
    }
}

#Preview {
    HealthPage()
        .environment(WalletViewModel())
}

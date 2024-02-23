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
            }
            .listRowInsets(.none)
            .navigationTitle("Gesundheit")
        }
    }
}

#Preview {
    HealthPage()
        .environment(WalletViewModel())
}

//
//  HealthPage.swift
//  HospitalCash
//
//  Created by hschaeufler on 23.02.24.
//

import SwiftUI

struct HealthPage: View {
    @Environment(WalletViewModel.self) private var walletVM
    @State private var claimDiscountVM = ClaimDiscountViewModel()
    @State private var weeklyStepsVM = WeeklyStepsViewModel()
    @State private var dailyStepsVM = DailyStepsViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                    DailyStepsStateView()
                        .listRowInsets(EdgeInsets())
                    WeeklyStepsStateView()
                        .listRowInsets(EdgeInsets())
                    ClaimDiscountStateView()
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
        .environment(claimDiscountVM)
        .environment(weeklyStepsVM)
        .environment(dailyStepsVM)
    }
}

#Preview {
    HealthPage()
        .environment(WalletViewModel())
}

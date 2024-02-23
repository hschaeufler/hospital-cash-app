//
//  HomePage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 26.01.24.
//

import SwiftUI

struct HomePage: View {
    @Environment(WalletViewModel.self) private var walletVM
    
    var body: some View {
        NavigationStack {
            TabView {
                ContractPage()
                    .tabItem { Label("Contract", systemImage: "folder.badge.person.crop") }
                HealthPage()
                    .tabItem { Label("Contract", systemImage: "heart.circle")}
            }
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
    HomePage()
        .environment(WalletViewModel())
}

//
//  HomePage.swift
//  HospitalCash
//
//  Created by hschaeufler on 26.01.24.
//

import SwiftUI

struct HomePage: View {
    @Environment(WalletViewModel.self) private var walletVM
    
    var body: some View {
        TabView {
            ContractPage()
                .tabItem {
                    Label(
                        "Vertrag",
                        systemImage: "folder.badge.person.crop"
                    )
                }
            HealthPage()
                .tabItem {
                    Label(
                        "Gesundheit",
                        systemImage: "heart.circle"
                    )
                }
        }
    }
}

#Preview {
    HomePage()
        .environment(WalletViewModel())
}

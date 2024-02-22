//
//  WelcomePage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 22.02.24.
//

import SwiftUI

struct WelcomePage: View {
    @ScaledMetric var verticalPadding = 5
    @State private var showPremiumCalculator = false
    @State private var showConnectWithMetamask = false
    
    @Environment(WalletVM.self) private var walletVM
    
    var body: some View {
        @Bindable var walletVM = walletVM
        
        WalletErrorViewBuilder {
            VStack {
                Spacer()
                HospitalCashLogo()
                Spacer()
                ProductDescriptionGroup()
                    .padding(.horizontal, 15)
                Spacer()
                InsuranceAdvantagesColumn()
                    .padding(.horizontal, 5)
                Spacer()
                BottomBar(verticalPadding: verticalPadding) {
                    VStack {
                        ProminentButton("Jetzt Beitrag berechnen") {
                            showPremiumCalculator.toggle()
                        }
                        if walletVM.state != .isConnected {
                            LoginButton {
                                showConnectWithMetamask.toggle()
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $showPremiumCalculator) {
                UnderwritingSheet()
            }
            .sheet(isPresented: $showConnectWithMetamask) {
                ConnectWithWalletPage()
                    .environment(walletVM)
            }
        }
    }
}

#Preview {
    NavigationStack {
        WelcomePage()
            .environment(WalletVM())
    }
}

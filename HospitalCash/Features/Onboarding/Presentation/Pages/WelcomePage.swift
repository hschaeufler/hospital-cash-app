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
    
    @Environment(WalletVM.self) private var walletVM
    
    var body: some View {
        @Bindable var walletVM = walletVM
        
        WalletSheetViewBuilder {
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
                                    walletVM.handleLogin()
                                }
                            }
                        }
                    }
                }
                .sheet(isPresented: $showPremiumCalculator) {
                    UnderwritingSheet()
                }
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

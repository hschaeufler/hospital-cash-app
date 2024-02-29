//
//  WelcomePage.swift
//  HospitalCash
//
//  Created by hschaeufler on 22.02.24.
//

import SwiftUI

struct WelcomePage: View {
    @ScaledMetric var verticalPadding = 5
    @State private var showPremiumCalculator = false
    
    @Environment(WalletViewModel.self) private var walletVM
    
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
                                walletVM.showUnderwriting()
                            }
                            if walletVM.state != .isConnected {
                                LoginButton {
                                    walletVM.showLogin()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        WelcomePage()
            .environment(WalletViewModel())
    }
}

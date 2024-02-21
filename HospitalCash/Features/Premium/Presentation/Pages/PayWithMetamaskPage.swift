//
//  PayWithMetamaskPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 15.02.24.
//

import SwiftUI

struct PayWithMetamaskPage: View {
    @Environment(PremiumCalculationVM.self) private var viewModel
    var isPayment: Bool
    
    var body: some View {
        NavigationStack {
            SheetPageLayout(
                isPayment
                ? "Pay with Metamask"
                : "Connect with Metamask") {
                    VStack(content: {
                        MetaMaskButton(
                            titleKey: isPayment
                            ? "Pay with"
                            : "Connect with"
                        ) {
                            Task {
                                isPayment ?
                                await viewModel.underwriteContract() :
                                await viewModel.connectWallet()
                            }
                        }
                        .padding(10)
                        Spacer()
                    })
                }
        }
        .presentationDetents([.fraction(1 / 3)])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    PayWithMetamaskPage(isPayment: false)
        .environment(PremiumCalculationVM())
}

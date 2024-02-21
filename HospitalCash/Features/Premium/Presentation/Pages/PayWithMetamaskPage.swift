//
//  PayWithMetamaskPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 15.02.24.
//

import SwiftUI

struct PayWithMetamaskPage: View {
    var isPayment: Bool
    
    @Environment(PremiumCalculationVM.self) private var viewModel
    
    var body: some View {
        SheetPageLayout("Pay with Metamask") {
            VStack(content: {
                MetaMaskButton(
                    titleKey: isPayment ? "Pay with" : "Connect with"
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
}

#Preview {
    PayWithMetamaskPage(isPayment: true)
        .environment(PremiumCalculationVM())
}

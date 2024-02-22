//
//  PayWithMetamaskPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 15.02.24.
//

import SwiftUI

struct PayWithWalletPage: View {
    var action: () -> Void
    
    var body: some View {
        NavigationStack {
            SheetPageLayout("Pay with Metamask") {
                VStack {
                    MetaMaskButton(
                        titleKey: "Pay with",
                        action: action
                    )
                    .padding(10)
                    Spacer()
                }
            }
        }
        .presentationDetents([.fraction(1 / 3)])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    PayWithWalletPage {}
}

//
//  PayWithMetamaskPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 15.02.24.
//

import SwiftUI

struct PayWithWalletPage: View {
    @Environment(\.dismiss) private var dismiss
    var action: () -> Void
    
    var body: some View {
        NavigationStack {
            SheetLayout("Pay with Metamask", dismiss:{ dismiss() }) {
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

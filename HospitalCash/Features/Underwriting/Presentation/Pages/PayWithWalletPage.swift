//
//  PayWithMetamaskPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 15.02.24.
//

import SwiftUI

struct PayWithWalletPage: View {
    @Environment(UnderwritingVM.self) private var viewModel
    
    var body: some View {
        NavigationStack {
            SheetPageLayout("Pay with Metamask") {
                VStack {
                    MetaMaskButton(
                        titleKey: "Pay with"
                    ) {
                        Task {
                            await viewModel.underwriteContract()
                        }
                    }
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
    PayWithWalletPage()
        .environment(UnderwritingVM())
}

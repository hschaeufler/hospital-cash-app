//
//  ConnectWithWalletPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 22.02.24.
//
import SwiftUI

struct ConnectWithWalletPage: View {
    @Environment(WalletVM.self) private var viewModel
    
    var body: some View {
        NavigationStack {
            SheetPageLayout("Connect with Metamask") {
                    VStack(content: {
                        MetaMaskButton(
                            titleKey: "Connect with"
                        ) {
                            Task {
                                await viewModel.handleConnectWallet()
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
        .environment(UnderwritingVM())
}

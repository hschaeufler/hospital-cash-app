//
//  ConnectWithWalletPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 22.02.24.
//
import SwiftUI

struct ConnectWithWalletPage: View {
    var action: () -> Void
    
    var body: some View {
        WalletErrorViewBuilder {
            NavigationStack {
                SheetPageLayout("Connect with Metamask") {
                    VStack(content: {
                        MetaMaskButton(
                            titleKey: "Connect with",
                            action: action
                        )
                        .padding(10)
                        Spacer()
                    })
                }
            }
            .presentationDetents([.fraction(1 / 3)])
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    PayWithWalletPage {}
}

//
//  ConnectWithWalletPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 22.02.24.
//
import SwiftUI

struct ConnectWithWalletPage: View {
    @Environment(\.dismiss) private var dismiss
    
    var action: () -> Void
    
    
    var body: some View {
        WalletErrorViewBuilder {
            NavigationStack {
                SheetLayout("Connect with Metamask", dismiss:{dismiss()}) {
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

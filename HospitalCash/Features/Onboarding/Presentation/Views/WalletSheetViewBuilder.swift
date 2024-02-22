//
//  WalletSheetViewBuilder.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 22.02.24.
//

import SwiftUI

struct WalletSheetViewBuilder<Content>: View where Content : View {
    @Environment(WalletVM.self) private var walletVM
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        content()
            .sheet(isPresented: Binding<Bool>(
                get: { walletVM.state == .isConnecting },
                set: { _ in }
            )) {
                ConnectWithWalletPage {
                    Task {
                        await walletVM.handleConnectWallet()
                    }
                }
            }
    }
}

#Preview {
    let vm = WalletVM()
    vm.state = .isConnecting
    
    return Group {
        WalletSheetViewBuilder(content: {
            Text("Hallo!")
        })
        .environment(vm)
    }
}

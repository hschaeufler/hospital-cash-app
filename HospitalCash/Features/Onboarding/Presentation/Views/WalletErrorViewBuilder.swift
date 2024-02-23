//
//  WalletErrorViewBuilder.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 22.02.24.
//

import SwiftUI

struct WalletErrorViewBuilder<Content>: View where Content: View {
    @Environment(WalletViewModel.self) private var walletVM
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ErrorViewBuilder(titleKey: "Fehler") {
            content()
        } error: {
            if case .error(let error) = walletVM.state {
                return LocalizedStringKey(error)
            }
            return nil
        }
    }
}

#Preview {
    WalletErrorViewBuilder {
        Text("Homepage")
    }
    .environment(WalletViewModel())
}

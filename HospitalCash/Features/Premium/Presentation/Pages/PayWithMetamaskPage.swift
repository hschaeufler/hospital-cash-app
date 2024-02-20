//
//  PayWithMetamaskPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 15.02.24.
//

import SwiftUI

struct PayWithMetamaskPage: View {
    @Environment(PremiumCalculationVM.self) private var viewModel
    
    var body: some View {
        SheetPageLayout("Pay with Metamask") {
            VStack(content: {
                PayWithMetaMaskButton {
                    Task {
                        await viewModel.underwriteContract();
                    }
                }
                .padding(10)
                Spacer()
            })
        }
    }
}

#Preview {
    PayWithMetamaskPage()
        .environment(PremiumCalculationVM())
}

//
//  PayWithMetamaskPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 15.02.24.
//

import SwiftUI

struct PayWithMetamaskPage: View {
    var body: some View {
        SheetPageLayout("Pay with Metamask") {
            VStack(content: {
                PayWithMetaMaskButton {
                    
                }
                .padding(10)
                Spacer()
            })
        }
    }
}

#Preview {
    PayWithMetamaskPage()
}

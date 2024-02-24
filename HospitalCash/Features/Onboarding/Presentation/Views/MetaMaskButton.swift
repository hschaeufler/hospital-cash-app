//
//  MetaMaskButton.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 15.02.24.
//

import SwiftUI

struct MetaMaskButton: View {
    var titleKey: LocalizedStringKey
    var action: () -> Void
    
    var body: some View {
        BorderedInkwell (action: action) {
            VStack(spacing: 0) {
                Text(titleKey)
                    .font(.title2)
                Image("metamask_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
            }
        }
    }
}

#Preview {
    MetaMaskButton (titleKey: "Pay With") {}
}

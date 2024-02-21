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
        Button ( action: action, label: {
            VStack(spacing: 0) {
                Text(titleKey)
                    .font(.title2)
                Image("metamask_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
            }
            .padding(5)
            .background {
                RoundedRectangle(
                    cornerRadius: 10,
                    style: .continuous
                )
                .stroke(.gray, lineWidth: 1.0)
            }
        })
        .buttonStyle(.plain)
    }
}

#Preview {
    MetaMaskButton (titleKey: "Pay With") {}
}

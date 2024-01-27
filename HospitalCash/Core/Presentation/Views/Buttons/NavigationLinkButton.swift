//
//  NavigationLinkButton.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 27.01.24.
//

import SwiftUI

struct NavigationLinkButton<Destination> : View where Destination : View {
    var titleKey: LocalizedStringKey
    @ViewBuilder var destination: () -> Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
            ButtonLabel(titleKey)
        }
        .buttonStyle(.bordered)
        .tint(.blue)
        .padding()
    }
}

#Preview {
    NavigationStack {
        NavigationLinkButton(titleKey: "Weiter") {
            BMIPage()
        }
    }
}

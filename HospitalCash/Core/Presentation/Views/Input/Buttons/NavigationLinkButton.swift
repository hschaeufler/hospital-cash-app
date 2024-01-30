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
    
    public init(_ titleKey: LocalizedStringKey, @ViewBuilder destination: @escaping () -> Destination) {
        self.titleKey = titleKey
        self.destination = destination
    }
    
    var body: some View {
        NavigationLink(destination: destination) {
            ButtonLabel(titleKey)
        }
        .buttonStyle(.bordered)
        .controlSize(.large)
        .tint(.blue)
        .padding()
    }
}

#Preview {
    NavigationStack {
        NavigationLinkButton("Weiter") {
            BMIPage()
        }
    }
}

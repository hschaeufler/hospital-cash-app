//
//  NavigationDestinationButton.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 27.01.24.
//

import SwiftUI

struct NavigationLinkButton<P> : View where P : Hashable {
    var titleKey: LocalizedStringKey
    var value: P
    
    public init(
        _ titleKey: LocalizedStringKey,
        value: P
    ) {
        self.titleKey = titleKey
        self.value = value
    }
    
    var body: some View {
        NavigationLink(value: value) {
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
        NavigationDestinationButton("Weiter") {
            BMIPage()
        }
    }
}

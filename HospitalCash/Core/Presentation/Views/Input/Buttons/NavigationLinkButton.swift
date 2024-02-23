//
//  NavigationDestinationButton.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 27.01.24.
//

import SwiftUI

struct NavigationLinkButton : View {
    var titleKey: LocalizedStringKey
    var value: any Hashable
    
    public init<P>(
        _ titleKey: LocalizedStringKey,
        value: P
    )  where P : Hashable {
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
        NavigationLinkButton("Weiter", value: UnderwritingViewModel.Destination.bmi)
    }
}

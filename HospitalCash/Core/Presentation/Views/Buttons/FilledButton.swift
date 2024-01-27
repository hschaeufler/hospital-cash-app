//
//  FilledButton.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 26.01.24.
//

import SwiftUI

struct FilledButton: View {
    var titleKey: LocalizedStringKey
    var action: () -> Void
    
    init(
        _ titleKey: LocalizedStringKey,
        action: @escaping () -> Void
    ) {
        self.titleKey = titleKey
        self.action = action
    }
    
    var body: some View {
        Button(
            action: action,
            label: {
                ButtonLabel(titleKey)
            }
        )
        .buttonStyle(.borderedProminent)
        .tint(.blue)
        .padding()
    }
}

#Preview {
    FilledButton("Jetzt Beitrag berechnen") {}
}

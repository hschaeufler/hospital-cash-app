//
//  ProminentButton.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 26.01.24.
//

import SwiftUI

struct ProminentButton: View {
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
        CustomButton(titleKey, action: action)
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(.blue)
            .padding()
    }
}

#Preview {
    ProminentButton("Jetzt Beitrag berechnen") {}
}

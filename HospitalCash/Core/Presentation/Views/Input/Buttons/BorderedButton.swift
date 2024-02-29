//
//  PaintedButton.swift
//  HospitalCash
//
//  Created by hschaeufler on 11.02.24.
//

import SwiftUI

struct BorderedButton: View {
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
            .buttonStyle(.bordered)
            .controlSize(.large)
            .tint(.blue)
            .padding()
    }
}

#Preview {
    BorderedButton("Jetzt Beitrag berechnen") {}
}

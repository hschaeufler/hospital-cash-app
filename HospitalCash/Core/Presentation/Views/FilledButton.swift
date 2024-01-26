//
//  FilledButton.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 26.01.24.
//

import SwiftUI

struct FilledButton: View {
    var caption: LocalizedStringKey
    var action: () -> Void
    
    var body: some View {
        Button(
            action: action,
            label: {
                Text(caption)
                    .font(.title3)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
            }
        )
        .buttonStyle(.borderedProminent)
        .tint(.blue)
        .padding()
    }
}

#Preview {
    FilledButton(caption: "Jetzt Beitrag berechnen") {}
}

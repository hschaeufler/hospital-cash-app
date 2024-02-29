//
//  CloseButton.swift
//  HospitalCash
//
//  Created by hschaeufler on 27.01.24.
//

import SwiftUI

struct CloseButton: View {
    var action: () -> Void
    
    var body: some View {
        Button("Abbrechen",
               systemImage: "xmark",
               role: .cancel,
               action: action
        )
        .buttonStyle(.bordered)
        .buttonBorderShape(.circle)
        .tint(.secondary)
    }
}

#Preview {
    CloseButton {}
}

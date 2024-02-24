//
//  RetryButton.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import SwiftUI

struct RetryButton: View {
    var action: () -> Void
    
    var body: some View {
        Button (action: action) {
            Label("Erneut versuchen", systemImage: "gobackward")
        }
        .buttonStyle(.bordered)
    }
}

#Preview {
    RetryButton() {}
}

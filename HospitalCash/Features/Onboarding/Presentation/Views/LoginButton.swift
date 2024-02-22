//
//  LoginButton.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 22.02.24.
//

import SwiftUI

struct LoginButton: View {
    var action: () -> Void
    
    var body: some View {
        HStack {
            Text("Bereits versichert?")
                .foregroundStyle(.secondary)
            Button("Jetzt einloggen", action: action)
        }
    }
}

#Preview {
    LoginButton {}
}

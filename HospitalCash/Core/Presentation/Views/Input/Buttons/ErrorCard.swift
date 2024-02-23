//
//  ErrorCard.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import SwiftUI

struct ErrorCard: View {
    var titleKey: LocalizedStringKey
    var subtitle: LocalizedStringKey
    var action: () -> Void
    
    init(_ titleKey: LocalizedStringKey,
         subtitle: LocalizedStringKey,
         action: @escaping () -> Void
    ) {
        self.titleKey = titleKey
        self.subtitle = subtitle
        self.action = action
    }
    
    
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
            Text(titleKey)
                .font(.title2)
                .bold()
            Text(subtitle)
                .multilineTextAlignment(.center)
                .font(.title3)
            Divider()
            RetryButton(action: action)
                .font(.title2)

        }
        .padding()
        .background {
            RoundedRectangle(
                cornerRadius: 10,
                style: .continuous
            )
            .stroke(.gray, lineWidth: 1.0)
        }
    }
}

#Preview {
    ErrorCard(
        "Netzwerkfehler",
        subtitle: "Das ist der Fehlergrund"
    ) {}
}

//
//  CustomButton.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 11.02.24.
//

import Foundation
import SwiftUI

struct CustomButton: View {
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
    }
}

#Preview {
    ProminentButton("Jetzt Beitrag berechnen") {}
}

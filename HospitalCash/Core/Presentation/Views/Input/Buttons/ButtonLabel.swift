//
//  ButtonLabel.swift
//  HospitalCash
//
//  Created by hschaeufler on 27.01.24.
//

import SwiftUI

struct ButtonLabel: View {
    var titleKey: LocalizedStringKey
    
    init(_ titleKey: LocalizedStringKey) {
        self.titleKey = titleKey
    }
    
    var body: some View {
        Text(titleKey)
            .font(.title3)
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    ButtonLabel("Test")
}

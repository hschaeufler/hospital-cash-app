//
//  OutputNumberField.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 28.01.24.
//

import SwiftUI

struct OutputFloatingPointField: View {
    var titleKey: LocalizedStringKey
    var number: Double
    var unit: LocalizedStringKey?
    
    var body: some View {
        HStack(content: {
            Text(titleKey)
                .fontWeight(.bold)
            Spacer()
            Text(number, format: .number)
                .textSelection(.enabled)
                .multilineTextAlignment(.trailing)
            if let unit = unit {
                Text(unit)
                    .foregroundStyle(.secondary)
            }
        })
    }
}

#Preview {
    Form {
        OutputFloatingPointField(titleKey: "BMI", number: 123)
        OutputFloatingPointField(titleKey: "BMI", number: 123, unit: "kg/m²")
    }
}

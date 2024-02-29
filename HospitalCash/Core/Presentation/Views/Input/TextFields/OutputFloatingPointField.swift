//
//  OutputNumberField.swift
//  HospitalCash
//
//  Created by hschaeufler on 28.01.24.
//

import SwiftUI

struct OutputFloatingPointField: View {
    var titleKey: LocalizedStringKey
    var caption: LocalizedStringKey?
    var number: Double
    var unit: LocalizedStringKey?
    var style = FieldStyle.oneLine
    var allowCopy = false
    
    @ScaledMetric var verticalSpacing = 10
    
    enum FieldStyle {
        case oneLine
        case multiLine
    }
    
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: verticalSpacing
        ) {
            if style == FieldStyle.multiLine {
                Text(titleKey)
                    .bold()
                if let caption = caption {
                    Text(caption)
                        .foregroundStyle(.secondary)
                }
            }
            HStack {
                if style == FieldStyle.oneLine {
                    Text(titleKey)
                        .bold()
                }
                Spacer()
                Text(number, format: .number)
                    .textSelection(.enabled)
                    .multilineTextAlignment(.trailing)
                if let unit = unit {
                    Text(unit)
                        .foregroundStyle(.secondary)
                }
                if allowCopy {
                    CopyButton(copyString: String(number))
                        .foregroundStyle(.secondary)
                        .padding(.leading, 10)
                }
            }
        }
    }
}

#Preview {
    Form {
        OutputFloatingPointField(titleKey: "BMI", number: 123)
        OutputFloatingPointField(titleKey: "BMI", number: 123, unit: "kg/m²")
        OutputFloatingPointField(titleKey: "BMI", caption: "Das ist ein Test", number: 123, style: .multiLine)
        OutputFloatingPointField(
            titleKey: "BMI",
            caption: "Das ist ein Test",
            number: 123, style: .multiLine,
            allowCopy: true
        )
    }
}

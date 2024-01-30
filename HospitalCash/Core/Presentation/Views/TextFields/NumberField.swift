//
//  NumberField.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 28.01.24.
//

import SwiftUI

struct NumberField: View {
    var titleKey: LocalizedStringKey
    var caption: LocalizedStringKey?
    @Binding var number: Int
    var range: ClosedRange<Int>?
    var unit: LocalizedStringKey?
    var step: Int
    var style: NumberFieldStyle
    
    @ScaledMetric var unitPlaceholderWidth = 40
    
    enum NumberFieldStyle {
        case oneLine
        case multiLine
    }
    
    
    init(_ titleKey: LocalizedStringKey,
         caption: LocalizedStringKey? = nil,
         number: Binding<Int>,
         unit: LocalizedStringKey? = nil,
         range: ClosedRange<Int>? = nil,
         step: Int = 1,
         style: NumberFieldStyle = NumberFieldStyle.oneLine
    ) {
        self.titleKey = titleKey
        self.caption = caption
        self._number = number
        self.unit = unit
        self.step = step
        self.style = style
    }
    
    var body: some View {
        VStack(alignment : .leading) {
            if style == NumberFieldStyle.multiLine {
                Text(titleKey)
                    .bold()
            }
            if let caption = caption {
                Text(caption)
                    .foregroundStyle(.secondary)
            }
            HStack {
                if style == NumberFieldStyle.oneLine {
                    Text(titleKey)
                        .bold()
                }
                TextField(titleKey, value: $number, format: .number)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                if let unit = unit {
                    Text(unit)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.trailing)
                } else {
                    Spacer()
                        .frame(width: unitPlaceholderWidth)
                }
                if let range = range {
                    Stepper(titleKey,value: $number, in: range, step: step)
                        .labelsHidden()
                        .fixedSize()
                } else {
                    Stepper(titleKey, value: $number, step: step)
                        .labelsHidden()
                }
            }
        }
    }
}

#Preview {
    Form {
        NumberField("Gewicht", number: .constant(5), unit: "cm", range: 0...250)
        NumberField("Gewicht", number: .constant(5), range: 0...250)
        NumberField("Krankentagegeld",
                    caption: "Welchen Betrag möchtest du tgl. bei einem Krankenhausaufenthalt erhalten?",
                    number: .constant(5),
                    range: 0...250,
                    style: NumberField.NumberFieldStyle.multiLine
        )
    }
}

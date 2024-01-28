//
//  NumberField.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 28.01.24.
//

import SwiftUI

struct NumberField: View {
    var titleKey: LocalizedStringKey
    @Binding var number: Int
    var range: ClosedRange<Int>?
    var unit: LocalizedStringKey?
    var step: Int

    
    init(_ titleKey: LocalizedStringKey, 
         number: Binding<Int>,
         range: ClosedRange<Int>? = nil,
         unit: LocalizedStringKey? = nil,
         step: Int = 1
    ) {
        self.titleKey = titleKey
        self._number = number
        self.unit = unit
        self.step = step
    }
    
    var body: some View {
        HStack {
            Text(titleKey)
            TextField(titleKey, value: $number, format: .number)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.trailing)
                .keyboardType(.numberPad)
            if let unit = unit {
                Text(unit)
                    .foregroundStyle(.secondary)
            }
            if let range = range {
                Stepper(value: $number, in: range, step: step) {}
            } else {
                Stepper(value: $number, step: step) {}
            }
        }
    }
}

#Preview {
    Form {
        NumberField("Gewicht", number: .constant(5), range: 0...250, unit: "cm")
        NumberField("Gewicht", number: .constant(5), range: 0...250)
    }
}

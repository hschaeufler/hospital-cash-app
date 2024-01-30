//
//  BMIPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 26.01.24.
//

import SwiftUI

struct BMIPage: View {
    @State private var height = 175
    @State private var weight = 80
    
    var bmi: Double {
        let heightInMeters = Double(height) / 100
        let bmi = (Double(weight) / (heightInMeters * heightInMeters))
        return (bmi * 100).rounded() / 100
    }
    
    var body: some View {
        SheetPageLayout("BMI") {
            VStack {
                Form {
                    Section {
                        NumberField("Größe", number: $height, unit: "cm", range: 0...250)
                        NumberField("Gewicht", number: $weight, unit: "kg", range: 0...250)
                    }
                    Section("Body Mass Index") {
                        OutputFloatingPointField(titleKey: "BMI", number: bmi, unit: "kg/m²")
                    }
                    InfoBox("Gesundheitsfragen", contentKey: "GESUNDHEITSFRAGEN_INFO")
                        .backgroundStyle(.windowBackground)
                        .listRowInsets(EdgeInsets())
                }
                NavigationLinkButton("Weiter") {
                    HealthQuestionPage()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        BMIPage()
    }
}

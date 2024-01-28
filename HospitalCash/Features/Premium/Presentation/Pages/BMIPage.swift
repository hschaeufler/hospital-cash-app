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
        VStack {
            Form {
                Section {
                    NumberField("Größe", number: $height, range: 0...250, unit: "cm")
                    NumberField("Gewicht", number: $weight, range: 0...250, unit: "kg")
                }
                Section("Body Mass Index") {
                    OutputFloatingPointField(titleKey: "BMI", number: bmi, unit: "kg/m²")
                }
            }
            NavigationLinkButton("Weiter") {
                HealthQuestionPage()
            }
        }
        .navigationTitle("BMI")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        BMIPage()
    }
}

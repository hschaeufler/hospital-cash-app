//
//  BMIPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 26.01.24.
//

import SwiftUI

struct BMIPage: View {
    @State private var gewicht = 0
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        VStack {
            Form {
                TextField("Gewicht", value: $gewicht, format: .number)
                TextField("Gewicht", value: $gewicht,formatter: NumberFormatter())
            }
            NavigationLinkButton(titleKey: "Weiter") {
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

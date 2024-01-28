//
//  PremiumCalculationPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 28.01.24.
//

import SwiftUI

struct PremiumCalculationPage: View {
    @State private var date = Date()
    @State private var amountHospitalCash = 0;
    
    var body: some View {
        VStack {
            Form {
                NumberField("Krankenhaustagegeld", number: $amountHospitalCash, range: 0...250, unit: "€", step:10)
                DatePicker(
                    "Versicherungsbeginn",
                    selection: $date,
                    displayedComponents: [.date]
                )
                DatePicker(
                    "Geburtsdatum",
                    selection: $date,
                    displayedComponents: [.date]
                )
            }
            NavigationLinkButton("Weiter") {
                PremiumCalculationPage()
            }
        }
        .navigationTitle("Beitrag berechnen")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    PremiumCalculationPage()
}

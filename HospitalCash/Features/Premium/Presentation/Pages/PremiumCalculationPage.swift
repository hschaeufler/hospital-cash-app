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
        SheetPageLayout("Beitrag berechnen") {
            VStack {
                Form {
                    NumberField("Höhe Krankenhaustagegeld",
                                caption: "Welchen Betrag möchtest du tgl. bei einem Krankenhausaufenthalt erhalten?",
                                number:  $amountHospitalCash,
                                unit: "€",
                                range: 0...250,
                                step: 10,
                                style: NumberField.NumberFieldStyle.multiLine
                    )
                    DatePicker(
                        "Versicherungsbeginn",
                        selection: $date,
                        displayedComponents: [.date]
                    )
                    .bold()
                    DatePicker(
                        "Geburtsdatum",
                        selection: $date,
                        displayedComponents: [.date]
                    )
                    .bold()
                }
                NavigationLinkButton("Beitrag berechnen") {
                    PremiumDetailPage()
                }
            }
        }
    }
}

#Preview {
    PremiumCalculationPage()
}

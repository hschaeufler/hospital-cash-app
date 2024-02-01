//
//  PremiumCalculationPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 28.01.24.
//

import SwiftUI

struct PremiumCalculationPage: View {
    @Environment(PremiumCalculationVM.self) private var premiumCalculationVm
    
    var body: some View {
        @Bindable var premiumCalculationVm = premiumCalculationVm
        
        SheetPageLayout("Beitrag berechnen") {
            VStack {
                Form {
                    NumberField("Höhe Krankenhaustagegeld",
                                caption: "Welchen Betrag möchtest du tgl. bei einem Krankenhausaufenthalt erhalten?",
                                number:  $premiumCalculationVm.amountHospitalCashEur,
                                unit: "€",
                                range: 0...250,
                                step: 10,
                                style: NumberField.NumberFieldStyle.multiLine
                    ).onChange(of: premiumCalculationVm.amountHospitalCashEur) { oldValue, newValue in
                        Task {
                            await premiumCalculationVm.calculateEurInEth()
                        }
                    }
                    Text("\(premiumCalculationVm.amountHospitalCashEth)")
                    DatePicker(
                        "Versicherungsbeginn",
                        selection: $premiumCalculationVm.insuranceDate,
                        in: Date.now...,
                        displayedComponents: [.date]
                    )
                    .bold()
                    DatePicker(
                        "Geburtsdatum",
                        selection: $premiumCalculationVm.birthDate,
                        in: ...Date.now,
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
        .environment(PremiumCalculationVM())
}

//
//  BMIPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 26.01.24.
//

import SwiftUI

struct BMIPage: View {
    @Environment(PremiumCalculationVM.self) private var premiumCalculationVm
    
    var body: some View {
        @Bindable var premiumCalculationVm = premiumCalculationVm
        
        SheetPageLayout("BMI") {
            VStack {
                Form {
                    Section {
                        NumberField("Größe", number: $premiumCalculationVm.height, unit: "cm", range: 0...250)
                        NumberField("Gewicht", number: $premiumCalculationVm.weight, unit: "kg", range: 0...250)
                    }
                    Section("Body Mass Index") {
                        OutputFloatingPointField(titleKey: "BMI", number: premiumCalculationVm.bmi, unit: "kg/m²")
                    }
                    InfoBox("Gesundheitsfragen", contentKey: "GESUNDHEITSFRAGEN_INFO")
                        .backgroundStyle(.windowBackground)
                        .listRowInsets(EdgeInsets())
                }
                BorderedButton("Weiter") {
                    Task {
                        await premiumCalculationVm.checkBMI()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        BMIPage()
            .environment(PremiumCalculationVM())
    }
}

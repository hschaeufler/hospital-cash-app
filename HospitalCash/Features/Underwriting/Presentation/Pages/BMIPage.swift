//
//  BMIPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 26.01.24.
//

import SwiftUI

struct BMIPage: View {
    @Environment(UnderwritingViewModel.self) private var underwritingVM
    
    var body: some View {
        @Bindable var underwritingVM = underwritingVM
        
        UnderwritingSheetLayout("BMI") {
            VStack {
                Form {
                    Section {
                        NumberField("Größe", number: $underwritingVM.height, unit: "cm", range: 0...250)
                        NumberField("Gewicht", number: $underwritingVM.weight, unit: "kg", range: 0...250)
                    }
                    Section("Body Mass Index") {
                        OutputFloatingPointField(titleKey: "BMI", number: underwritingVM.bmi, unit: "kg/m²")
                    }
                    InfoBox("Gesundheitsfragen", contentKey: "GESUNDHEITSFRAGEN_INFO")
                        .backgroundStyle(.windowBackground)
                        .listRowInsets(EdgeInsets())
                }
                BorderedButton("Weiter") {
                    Task {
                        await underwritingVM.checkBMI()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        BMIPage()
            .environment(UnderwritingViewModel())
            .environment(WalletViewModel())
    }
}

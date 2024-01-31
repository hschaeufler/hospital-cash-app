//
//  PremiumCalculationSheet.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 27.01.24.
//

import SwiftUI

struct PremiumCalculationSheet: View {
    @State private var premiumCalculationVM = PremiumCalculationVM()
    
    var body: some View {
        NavigationStack {
            BMIPage()
        }
        .presentationDragIndicator(.visible)
        .environment(premiumCalculationVM)
    }
}

#Preview {
    PremiumCalculationSheet()
}

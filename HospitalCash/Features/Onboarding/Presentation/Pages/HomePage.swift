//
//  HomePage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 26.01.24.
//

import SwiftUI

struct HomePage: View {
    @ScaledMetric var verticalPadding = 5
    @State private var showingPremiumCalculator = false
    
    var body: some View {
        VStack {
            Spacer()
            HospitalCashLogo()
            Spacer()
            ProductDescriptionGroup()
                .padding(.horizontal, 15)
            Spacer()
            InsuranceAdvantagesColumn()
                .scaledToFit()
                .padding(.horizontal, 5)
            Spacer()
            BottomBar(verticalPadding: verticalPadding) {
                FilledButton("Jetzt Beitrag berechnen") {
                    showingPremiumCalculator.toggle()
                }
                .sheet(isPresented: $showingPremiumCalculator) {
                    PremiumCalculationSheet()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomePage()
    }
}

//
//  HomePage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 26.01.24.
//

import SwiftUI

struct HomePage: View {
    @ScaledMetric var verticalPadding = 5
    @State private var showPremiumCalculator = false
    @State private var showConnectWithMetamask = false
    
    var body: some View {
        VStack {
            Spacer()
            HospitalCashLogo()
            Spacer()
            ProductDescriptionGroup()
                .padding(.horizontal, 15)
            Spacer()
            InsuranceAdvantagesColumn()
                .padding(.horizontal, 5)
            Spacer()
            BottomBar(verticalPadding: verticalPadding) {
                VStack {
                    ProminentButton("Jetzt Beitrag berechnen") {
                        showPremiumCalculator.toggle()
                    }
                    HStack {
                        Text("Bereits versichert?")
                            .foregroundStyle(.secondary)
                        Button("Jetzt einloggen") {
                            showConnectWithMetamask.toggle()
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showPremiumCalculator) {
            PremiumCalculationSheet()
        }
        .sheet(isPresented: $showConnectWithMetamask) {
            PayWithMetamaskPage(isPayment: false)
        }
    }
}

#Preview {
    NavigationStack {
        HomePage()
    }
}

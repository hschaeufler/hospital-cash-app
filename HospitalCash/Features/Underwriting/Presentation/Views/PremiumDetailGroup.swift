//
//  PremiumDetailGroup.swift
//  HospitalCash
//
//  Created by hschaeufler on 10.02.24.
//

import SwiftUI

struct PremiumDetailGroup: View {
    var yearlyPremiumEth: Double
    var yearlyPremiumEur: Double
    var hcAmountEth: Double
    var hcAmountEur: Double
    
    var body: some View {
        VStack(spacing: 5) {
            Text("\(hcAmountEth.formatted()) Eth / ~ \(hcAmountEur.formatted()) €")
                .foregroundStyle(.green)
                .font(.title2)
                .bold()
            Text("Krankenhaustagegeld")
                .font(.title)
                .bold()
            Text("für nur")
                .font(.title2)
                .bold()
            Text("\(yearlyPremiumEth.formatted()) Eth / ~ \(yearlyPremiumEur.formatted()) €")
                .foregroundStyle(.green)
                .font(.title2)
                .bold()
            Text("pro Jahr")
                .font(.title2)
                .bold()
        }
    }
}

#Preview {
    PremiumDetailGroup(
        yearlyPremiumEth: 100,
        yearlyPremiumEur: 100,
        hcAmountEth: 100,
        hcAmountEur: 100
    )
}

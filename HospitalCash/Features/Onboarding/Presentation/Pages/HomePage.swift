//
//  HomePage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 26.01.24.
//

import SwiftUI

struct HomePage: View {
    @ScaledMetric var verticalPadding = 5
    
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
                FilledButton("Jetzt Beitrag berechnen") {}
            }
        }
    }
}

#Preview {
    HomePage()
}

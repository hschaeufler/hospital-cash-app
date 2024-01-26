//
//  HomePage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 26.01.24.
//

import SwiftUI

struct HomePage: View {
    @ScaledMetric var spacing = 15
    @ScaledMetric var maxHeightButtonGroup = 100
    
    var body: some View {
        VStack {
            Spacer()
            HospitalCashLogo()
            CustomDivider(maxWidth: 150)
            ProductDescriptionText()
            CustomDivider(maxWidth: 150)
            Spacer()
            InsuranceAdvantagesColumn()
                .scaledToFit()
                .padding(.horizontal, 5)
            Spacer()
            BottomBar {
                FilledButton("Jetzt Beitrag berechnen") {}
            }
        }
    }
}

#Preview {
    HomePage()
}

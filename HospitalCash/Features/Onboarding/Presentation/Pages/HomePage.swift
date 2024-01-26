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
            VStack (spacing: spacing) {
                HospitalCashLogo()
                Divider()
                    .frame(maxWidth: 150)
                ProductDescriptionText()
                Divider()
                    .frame(maxWidth: 150)
            }
            .padding(.horizontal, 10)
            Spacer()
            InsuranceAdvantagesColumn()
                .scaledToFit()
                .padding(.horizontal, 5)
            Spacer()
            ZStack {
                Rectangle()
                    .fill(Color(.systemGray5))
                    .ignoresSafeArea()
                    .frame(maxHeight: maxHeightButtonGroup)
                
                FilledButton(caption: "Jetzt Beitrag berechnen") {}
            }
        }
    }
}

#Preview {
    HomePage()
}

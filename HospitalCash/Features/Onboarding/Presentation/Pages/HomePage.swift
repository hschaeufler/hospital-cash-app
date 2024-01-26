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
                Text("PRODUKT_BESCHREIBUNG_HOSPITALCASH")
                    .font(.callout)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
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
                
                Button {} label: {
                    Text("Jetzt Beitrag berechnen")
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .padding()
            }
        }
    }
}

#Preview {
    HomePage()
}

//
//  HomePage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 26.01.24.
//

import SwiftUI

struct HomePage: View {
    @ScaledMetric var spacing = 20
    @ScaledMetric var maxHeightButtonGroup = 100
    
    var body: some View {
        VStack(spacing: spacing) {
            VStack {
                Image(systemName: "cross.case.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.tint)
                    .frame(maxWidth: 75)
                Text("Hospital Cash")
                    .font(.largeTitle)
                    .fontDesign(.serif)
                Divider()
                    .frame(maxWidth: 150)
                Text("PRODUKT_BESCHREIBUNG_HOSPITALCASH")
                    .font(.title2)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
                Divider()
                    .frame(maxWidth: 150)
                Text("Deine Vorteile")
                    .font(.title2)
                    .bold()
            }
            .padding()
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

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
                    .font(.callout)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
                Divider()
                    .frame(maxWidth: 150)
            }
            .padding(.horizontal, 10)
            Spacer()
            Text("Deine Vorteile")
                .font(.title2)
                .bold()
            List {
                ListTile(
                    systemName: "bed.double.circle",
                    title: "Individueller Leistungsumfang",
                    subtitle: "Bestimme selbst die Tagegeldhöhe"
                )
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 10, leading: 5, bottom: 5, trailing: 0))
                ListTile(
                    systemName: "cube.transparent",
                    title: "Volle Transparenz",
                    subtitle: "Versicherung auf Blockchain einsehbar"
                )
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 10, leading: 5, bottom: 5, trailing: 0))
                ListTile(
                    systemName: "bed.double.circle",
                    title: "Voll automatisiert",
                    subtitle: "Keine lästigen Wartezeiten"
                )
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 10, leading: 5, bottom: 5, trailing: 0))
            }
            .listStyle(.plain)

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

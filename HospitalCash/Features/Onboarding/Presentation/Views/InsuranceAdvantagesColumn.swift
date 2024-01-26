//
//  AdvantagesRow.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 26.01.24.
//

import SwiftUI

struct InsuranceAdvantagesColumn: View {
    var body: some View {
        VStack(spacing: 15) {
            Text("Deine Vorteile")
                .font(.title2)
                .bold()
                .padding(.bottom, 10)
            ListTile(
                systemName: "bed.double.circle",
                title: "Individueller Leistungsumfang",
                subtitle: "Bestimme selbst die Tagegeldhöhe"
            )
            ListTile(
                systemName: "cube.transparent",
                title: "Volle Transparenz",
                subtitle: "Versicherung auf Blockchain einsehbar"
            )
            ListTile(
                systemName: "bed.double.circle",
                title: "Voll automatisiert",
                subtitle: "Keine lästigen Wartezeiten"
            )
        }
    }
}

#Preview {
    InsuranceAdvantagesColumn()
}

//
//  InsuranceAdvantagesColumn.swift
//  HospitalCash
//
//  Created by hschaeufler on 26.01.24.
//

import SwiftUI

struct InsuranceAdvantagesColumn: View {
    @ScaledMetric var spacing = 15.0
    
    var body: some View {
        VStack(spacing: spacing) {
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
                systemName: "gauge.open.with.lines.needle.33percent.and.arrowtriangle.from.0percent.to.50percent",
                title: "Voll automatisiert",
                subtitle: "Keine lästigen Wartezeiten"
            )
        }
    }
}

#Preview {
    InsuranceAdvantagesColumn()
}

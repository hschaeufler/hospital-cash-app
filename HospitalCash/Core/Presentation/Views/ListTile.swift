//
//  ListTile.swift
//  HospitalCash
//
//  Created by hschaeufler on 26.01.24.
//

import SwiftUI

struct ListTile: View {
    @ScaledMetric var titleSpacing = 5
    @ScaledMetric var iconSpacing = 10
    
    var systemName: String
    var title: LocalizedStringKey
    var subtitle: LocalizedStringKey
    
    var body: some View {
        HStack(spacing: iconSpacing) {
            Avatar(systemName: systemName)
                .font(.title)
            VStack(alignment: .leading, spacing: titleSpacing) {
                Text(title)
                    .font(.title3)
                    .bold()
                Text(subtitle)
                    .font(.body)
            }
            Spacer()
        }
    }
}

#Preview {
    ListTile(
        systemName: "bed.double.circle",
        title: "Individueller Leistungsumfang",
        subtitle: "Bestimme selbst die Tagegeldhöhe"
    )
}

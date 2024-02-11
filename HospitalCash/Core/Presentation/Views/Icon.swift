//
//  Icon.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 26.01.24.
//

import SwiftUI

struct Icon: View {
    @ScaledMetric var spacing = 5
    
    var title: String
    var subtitle: String
    
    var body: some View {
        HStack {
            Image(systemName: "bed.double.circle")
            VStack(alignment: .leading, spacing: spacing) {
                Text(title)
                    .font(.title2)
                    .bold()
                Text(subtitle)
                    .font(.title3)
            }
            Spacer()
        }
    }
}

#Preview {
    Icon(
        title: "Individueller Leistungsumfang",
        subtitle: "Bestimme selbst die Tagegeldhöhe"
    )
}

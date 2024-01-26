//
//  ProductDescriptionText.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 26.01.24.
//

import SwiftUI

struct ProductDescriptionText: View {
    var body: some View {
        Text("PRODUKT_BESCHREIBUNG_HOSPITALCASH")
            .font(.callout)
            .foregroundColor(Color.gray)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    ProductDescriptionText()
}

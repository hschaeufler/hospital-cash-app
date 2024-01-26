//
//  HospitalDescriptionGroup.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 26.01.24.
//

import SwiftUI

struct ProductDescriptionGroup: View {
    @ScaledMetric var spacing = 20
    
    var body: some View {
        VStack(spacing: spacing) {
            CustomDivider(maxWidth: 150)
            ProductDescriptionText()
            CustomDivider(maxWidth: 150)
        }
    }
}

#Preview {
    ProductDescriptionGroup()
}

//
//  HospitalDescriptionGroup.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 26.01.24.
//

import SwiftUI

struct HospitalDescriptionGroup: View {
    @ScaledMetric var spacing = 10
    
    var body: some View {
        VStack(spacing: spacing) {
            CustomDivider(maxWidth: 150)
            ProductDescriptionText()
            CustomDivider(maxWidth: 150)
        }
    }
}

#Preview {
    HospitalDescriptionGroup()
}

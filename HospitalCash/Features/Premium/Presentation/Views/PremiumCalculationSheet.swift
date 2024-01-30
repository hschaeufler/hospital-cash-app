//
//  PremiumCalculationSheet.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 27.01.24.
//

import SwiftUI

struct PremiumCalculationSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            BMIPage()
        }
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    PremiumCalculationSheet()
}

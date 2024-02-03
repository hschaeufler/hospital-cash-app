//
//  PremiumDetailPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 30.01.24.
//

import SwiftUI

struct PremiumDetailPage: View {
    @Environment(PremiumCalculationVM.self) private var premiumCalculationVm
    
    var body: some View {
        SheetPageLayout("Dein Beitrag") {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .task {
                    await premiumCalculationVm.caculatePremium()
                }
            
        }
    }
}

#Preview {
    PremiumDetailPage()
        .environment(PremiumCalculationVM())
}

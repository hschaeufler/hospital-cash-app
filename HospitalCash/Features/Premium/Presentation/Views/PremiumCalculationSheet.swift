//
//  PremiumCalculationSheet.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 27.01.24.
//

import SwiftUI

struct PremiumCalculationSheet: View {
    @State private var premiumCalculationVM = PremiumCalculationVM()
    
    var body: some View {
        NavigationStack(path: $premiumCalculationVM.path) {
            BMIPage()
                .navigationDestination(for: NavigationDestination.self) { destination in
                    switch destination {
                    case NavigationDestination.bmi:
                        BMIPage()
                    case NavigationDestination.healthQuestions:
                        HealthQuestionPage()
                    case NavigationDestination.premiumCalculation:
                        PremiumCalculationPage()
                    case NavigationDestination.premiumDetail:
                        PremiumDetailPage()
                    }
                }
        }
        .presentationDragIndicator(.visible)
        .environment(premiumCalculationVM)
    }
}

#Preview {
    PremiumCalculationSheet()
}

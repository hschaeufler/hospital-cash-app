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
        .alert(
            "Fehler",
            isPresented: $premiumCalculationVM.showError,
            presenting: premiumCalculationVM.error
        ) { error in
            Button("Ok", role: .cancel, action: {})
        } message: { error in
            Text(LocalizedStringKey(error.localizedDescription))
        }
        .presentationDragIndicator(.visible)
        .environment(premiumCalculationVM)
    }
}

#Preview {
    PremiumCalculationSheet()
}

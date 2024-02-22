//
//  PremiumCalculationSheet.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 27.01.24.
//

import SwiftUI

struct UnderwritingSheet: View {
    @State private var viewModel = UnderwritingVM()
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
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
                    case NavigationDestination.contractDetail:
                        ContractDetailPage()
                    }
                }
        }
        .alert(
            "Fehler",
            isPresented: $viewModel.showError,
            presenting: viewModel.error
        ) { error in
            Button("Ok", role: .cancel, action: {})
        } message: { error in
            Text(LocalizedStringKey(error.localizedDescription))
        }
        .presentationDragIndicator(.visible)
        .environment(viewModel)
    }
}

#Preview {
    UnderwritingSheet()
}

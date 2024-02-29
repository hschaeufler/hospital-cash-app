//
//  PremiumCalculationSheet.swift
//  HospitalCash
//
//  Created by hschaeufler on 27.01.24.
//

import SwiftUI

struct UnderwritingSheet: View {
    @State private var viewModel = UnderwritingViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            BMIPage()
                .navigationDestination(for: UnderwritingViewModel.Destination.self) { destination in
                    switch destination {
                    case UnderwritingViewModel.Destination.bmi:
                        BMIPage()
                    case UnderwritingViewModel.Destination.healthQuestions:
                        HealthQuestionPage()
                    case UnderwritingViewModel.Destination.premiumCalculation:
                        PremiumCalculationPage()
                    case UnderwritingViewModel.Destination.premiumDetail:
                        PremiumDetailPage()
                    case UnderwritingViewModel.Destination.contractDetail:
                        ContractDetailPage()
                    case UnderwritingViewModel.Destination.alreadyInsured:
                        AlreadyInsured()
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

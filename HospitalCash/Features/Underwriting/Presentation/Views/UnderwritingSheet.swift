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
                .navigationDestination(for: UnderwritingVM.Destination.self) { destination in
                    switch destination {
                    case UnderwritingVM.Destination.bmi:
                        BMIPage()
                    case UnderwritingVM.Destination.healthQuestions:
                        HealthQuestionPage()
                    case UnderwritingVM.Destination.premiumCalculation:
                        PremiumCalculationPage()
                    case UnderwritingVM.Destination.premiumDetail:
                        PremiumDetailPage()
                    case UnderwritingVM.Destination.contractDetail:
                        ContractDetailPage()
                    case UnderwritingVM.Destination.alreadyInsured:
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

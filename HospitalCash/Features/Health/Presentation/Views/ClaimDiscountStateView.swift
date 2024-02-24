//
//  ClaimDiscountStateView.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 24.02.24.
//

import Foundation
import SwiftUI

struct ClaimDiscountStateView: View {
    @State private var viewModel = ClaimDiscountViewModel()
    
    var body: some View {
        switch viewModel.state {
        case .loading:
            ProgessCard()
                .frame(height: 300)
        case .loaded:
            ClaimDiscountCard {
                Task {
                    await viewModel.handleClaimDiscount()
                }
            }
        case .error(let errorMessage):
            ErrorCard(
                "Ein Fehler ist aufgetreten",
                subtitle: LocalizedStringKey(errorMessage)) {
                    Task {
                        await viewModel.handleClaimDiscount()
                    }
                }
        case .accessDenied:
            ErrorCard(
                "Zugriff verweigert",
                subtitle: "Du musst den Zugriff auf deine Schrittdaten erlauben."
            ) {
                Task {
                    await viewModel.handleClaimDiscount()
                }
            }
        }
    }
}

#Preview {
    WeeklyStepsStateView()
        .environment(WeeklyStepsViewModel())
}

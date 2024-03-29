//
//  DailyStepcountStateView.swift
//  HospitalCash
//
//  Created by hschaeufler on 23.02.24.
//

import SwiftUI

struct DailyStepsStateView: View {
    @Environment(DailyStepsViewModel.self) private var viewModel
    
    var body: some View {
        switch viewModel.state {
        case .loading:
            ProgessCard()
                .frame(height: 300)
                .onAppear {
                    Task {
                        await viewModel.fetchDailySteps()
                    }
                }
        case .loaded(let steps, let stepLimit):
            DailyStepCountCard(
                todaysSteps: steps,
                recommendedSteps: stepLimit
            )
        case .error(let errorMessage):
            ErrorCard(
                "Ein Fehler ist aufgetreten",
                subtitle: LocalizedStringKey(errorMessage)) {
                    Task {
                        await viewModel.fetchDailySteps()
                    }
                }
        case .empty:
            ErrorCard(
                "Keine Daten",
                subtitle: "Scheinbar liegen für heute noch keine Schrittdaten vor."
            ) {
                Task {
                    await viewModel.fetchDailySteps()
                }
            }
        case .accessDenied:
            ErrorCard(
                "Zugriff verweigert",
                subtitle: "Du musst den Zugriff auf deine Schrittdaten erlauben."
            ) {
                Task {
                    await viewModel.fetchDailySteps()
                }
            }
        }
    }
}

#Preview {
    DailyStepsStateView()
        .environment(DailyStepsViewModel())
}

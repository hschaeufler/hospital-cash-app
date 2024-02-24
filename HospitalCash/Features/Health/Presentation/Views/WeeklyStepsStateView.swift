//
//  WeeklyStepsStateView.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 24.02.24.
//

import Foundation
import SwiftUI

struct WeeklyStepsStateView: View {
    @Environment(WeeklyStepsViewModel.self) private var viewModel
    
    var body: some View {
        switch viewModel.state {
        case .loading:
            ProgessCard()
                .frame(height: 300)
                .onAppear {
                    Task {
                        await viewModel.fetchWeeklySteps()
                    }
                }
        case .loaded(let weeklySteps, let stepLimit):
            WeeklyStepsCountCard(
                weeklySteps: weeklySteps,
                recommendedSteps: stepLimit
            ) {
                Task {
                    await viewModel.fetchWeeklySteps();
                }
            }
        case .error(let errorMessage):
            ErrorCard(
                "Ein Fehler ist aufgetreten",
                subtitle: LocalizedStringKey(errorMessage)) {
                    Task {
                        await viewModel.fetchWeeklySteps()
                    }
                }
        case .empty:
            ErrorCard(
                "Keine Daten",
                subtitle: "Scheinbar liegen keine Schrittdaten vor."
            ) {
                Task {
                    await viewModel.fetchWeeklySteps()
                }
            }
        case .accessDenied:
            ErrorCard(
                "Zugriff verweigert",
                subtitle: "Du musst den Zugriff auf deine Schrittdaten erlauben."
            ) {
                Task {
                    await viewModel.fetchWeeklySteps()
                }
            }
        }
    }
}

#Preview {
    WeeklyStepsStateView()
        .environment(WeeklyStepsViewModel())
}

//
//  DailyStepcountStateView.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import SwiftUI

struct DailyStepsStateView: View {
    var viewState: DailyStepsViewModel.ViewState
    
    var body: some View {
        switch viewState {
        case .loading:
            ProgressView()
        case .loaded(let steps):
            DailyStepcountChart(todaysSteps: steps)
        case .error(let errorMessage):
            Text(errorMessage)
        case .empty:
            Text("Keine Daten da")
        case .accessDenied:
            Text("Zugriff wird benötigt")
        }
    }
}

#Preview {
    DailyStepsStateView(viewState: .loaded(3000))
}

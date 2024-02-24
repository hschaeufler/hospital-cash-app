//
//  WeeklyStepsViewModel.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 24.02.24.
//

import SwiftUI
import Factory

@Observable class WeeklyStepsViewModel {
    @ObservationIgnored
    @Injected(\HealthContainer.getWeeklyStepCount) private var getWeeklyStepCount
    
    enum ViewState {
        case loading
        case loaded([StepDateCountEntity])
        case empty
        case accessDenied
        case error(String)
    }
    
    var state: ViewState = .loading
    
    func fetchWeeklySteps() async {
        do {
            let weeklySteps = try await self.getWeeklyStepCount()
            if !weeklySteps.isEmpty {
                self.state = .loaded(weeklySteps)
            } else {
                self.state = .empty
            }
        } catch CommonError.accessDenied {
            self.state = .accessDenied
        } catch {
            self.state = ViewState.error(error.localizedDescription)
        }
    }
}

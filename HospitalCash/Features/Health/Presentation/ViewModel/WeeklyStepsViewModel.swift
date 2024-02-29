//
//  WeeklyStepsViewModel.swift
//  HospitalCash
//
//  Created by hschaeufler on 24.02.24.
//

import SwiftUI
import Factory

@Observable class WeeklyStepsViewModel {
    @ObservationIgnored
    @Injected(\HealthContainer.getWeeklyStepCount) private var getWeeklyStepCount
    @ObservationIgnored
    @Injected(\HealthContainer.healthConfig) private var healthConfig
    
    enum ViewState {
        case loading
        case loaded([StepDateCountEntity], Double)
        case empty
        case accessDenied
        case error(String)
    }
    
    var state: ViewState = .loading
    
    func fetchWeeklySteps() async {
        do {
            self.state = .loading
            let weeklySteps = try await self.getWeeklyStepCount()
            if !weeklySteps.isEmpty {
                self.state = .loaded(weeklySteps, Double(healthConfig.stepLimit))
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

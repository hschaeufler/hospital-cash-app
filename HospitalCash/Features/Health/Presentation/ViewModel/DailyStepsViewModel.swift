//
//  DailyStepsViewModel.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//
import SwiftUI
import Factory

@Observable class DailyStepsViewModel {
    @ObservationIgnored
    @Injected(\HealthContainer.getTodayStepCount) private var getTodayStepCount
    
    enum ViewState {
        case loading
        case loaded(Double)
        case empty
        case accessDenied
        case error(String)
    }
    
    var state: ViewState = .loading
    
    func fetchDailySteps() async {
        do {
            let todaySteps = try await self.getTodayStepCount()
            if let todaySteps = todaySteps {
                self.state = .loaded(todaySteps)
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

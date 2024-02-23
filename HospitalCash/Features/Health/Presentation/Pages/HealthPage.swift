//
//  HealthPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import SwiftUI

struct HealthPage: View {
    @State private var dailyStepsVm = DailyStepsViewModel()
    
    var body: some View {
        VStack {
            DailyStepsStateView(viewState: dailyStepsVm.state)
                .onAppear {
                    Task {
                        await dailyStepsVm.fetchDailySteps()
                    }
                }
            Spacer()
            Text("Test")
        }
    }
}

#Preview {
    HealthPage()
}

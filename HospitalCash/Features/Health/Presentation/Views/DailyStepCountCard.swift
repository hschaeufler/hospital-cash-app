//
//  DailyStepCountCard.swift
//  HospitalCash
//
//  Created by hschaeufler on 23.02.24.
//

import SwiftUI

struct DailyStepCountCard: View {
    var todaysSteps: Double
    var recommendedSteps : Double
    
    var body: some View {
        DailyStepCountChart(
            todaysSteps: todaysSteps,
            recommendedSteps: 8000
        )
        .padding(20)
        .background {
            RoundedRectangle(
                cornerRadius: 10,
                style: .continuous
            )
            .stroke(.gray, lineWidth: 1.0)
        }
    }
}

#Preview {
    DailyStepCountCard(
        todaysSteps: 200,
        recommendedSteps: 8000
    )
}

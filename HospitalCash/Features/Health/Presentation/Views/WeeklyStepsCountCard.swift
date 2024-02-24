//
//  WeeklyStepsCountCard.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 24.02.24.
//

import Foundation
import SwiftUI


struct WeeklyStepsCountCard: View {
    var weeklySteps: [StepDateCountEntity]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(weeklySteps, id: \.date) { stepDateCount in
                    WeekdayStepCountChart(stepDateCount: stepDateCount)
                }
            }
        }
        .padding(.vertical, 20)
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
    WeeklyStepsCountCard(weeklySteps: [
        StepDateCountEntity(steps: 2000, date: Date()),
        StepDateCountEntity(steps: 1000, date: Date()),
        StepDateCountEntity(steps: 2900, date: Date())
    ])
}

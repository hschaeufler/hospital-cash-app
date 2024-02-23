//
//  DailyStepCountGroup.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import SwiftUI

struct DailyStepCountCard: View {
    var todaysSteps: Double
    
    var body: some View {
        DailyStepCountChart(todaysSteps: todaysSteps)
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
    DailyStepCountCard(todaysSteps: 200)
}

//
//  DailyStepcountChart.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import SwiftUI
import Charts

struct DailyStepCountChart: View {
    var todaysSteps: Double
    
    private let recommendedSteps = 8000.0
    private var remainingSteps: Double {
        recommendedSteps - todaysSteps
    }
    private let innerRadius: MarkDimension = .ratio(0.6)
    
    var body: some View {
        Chart {
            SectorMark(
                angle: .value("Heutige Schritte", todaysSteps),
                innerRadius: .ratio(0.6),
                angularInset: 3
            )
            .foregroundStyle(.primary)
            SectorMark(
                angle: .value("Übrige Schritte", remainingSteps),
                innerRadius: .ratio(0.7)
            )
            .foregroundStyle(.gray)
        }
        .chartBackground { proxy in
            VStack {
                Text("Heutige Schritte")
                    .foregroundStyle(.secondary)
                HStack(alignment: .bottom) {
                    Text(String(format: "%.0f", todaysSteps))
                        .font(.largeTitle)
                        .bold()
                    Text("👣")
                        .font(.caption)
                }
                Text("noch \(String(format: "%.0f", remainingSteps))")
                    .foregroundStyle(.secondary)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    DailyStepCountChart(todaysSteps: 6000)
}

//
//  DailyStepcountChart.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import SwiftUI
import Charts

struct DailyStepcountChart: View {
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
            .foregroundStyle(.green)
            SectorMark(
                angle: .value("Rest", remainingSteps),
                innerRadius: .ratio(0.7)
            )
            .foregroundStyle(.blue)
        }
        .chartBackground { proxy in
            VStack {
                Text("🏃")
                    .font(.system(size: 50))
                Text("\(todaysSteps.formatted())")
                    .font(.largeTitle)
                Text("🚩 \(recommendedSteps.formatted())")
                    .foregroundStyle(.secondary)
                    .font(.title2)
            }
        }
        .chartLegend(.hidden)
    }
}

#Preview {
    DailyStepcountChart(todaysSteps: 6000)
}

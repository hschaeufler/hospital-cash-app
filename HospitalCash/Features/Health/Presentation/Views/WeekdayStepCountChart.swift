//
//  WeekdayStepCountChart.swift
//  HospitalCash
//
//  Created by hschaeufler on 24.02.24.
//

import Foundation

import SwiftUI
import Charts

struct WeekdayStepCountChart: View {
    var stepDateCount: StepDateCountEntity
    var recommendedSteps: Double
    
    private var remainingSteps: Double {
        recommendedSteps - stepDateCount.steps
    }
    private var weekdaySymbol: String {
        let weekday = Calendar.current.component(.weekday, from: stepDateCount.date)
        let short = DateFormatter().shortWeekdaySymbols[weekday - 1]
        return short.replacingOccurrences(of: ".", with: "")
    }
    
    var body: some View {
        VStack {
            Chart {
                SectorMark(
                    angle: .value("Heutige Schritte", stepDateCount.steps),
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
                    Text(weekdaySymbol)
                        .font(.title)
                        .foregroundStyle(.secondary)
                        .bold()
                    if stepDateCount.isSubmitted ?? false {
                        Image(systemName: "checkmark.icloud.fill")
                            .font(.title)
                            .foregroundStyle(.blue)
                    } else {
                        Text("")
                            .font(.title)
                    }
                }
            }
            .aspectRatio(1, contentMode: .fit)
            Text(String(format: "%.0f", stepDateCount.steps))
                .font(.title)
                .bold()
                .foregroundStyle(.secondary)
        }
        .frame(height: 150)
    }
}

#Preview {
    WeekdayStepCountChart(
        stepDateCount: StepDateCountEntity(
            steps: 2000,
            date: Date(),
            isSubmitted: true
        ),
        recommendedSteps: 8000
    )
}

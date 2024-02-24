//
//  DateUtils.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 21.02.24.
//

import Foundation

struct DateUtils {
    static func tommorow() -> Date {
        return Calendar.current.date(
            byAdding: .day,
            value: 1,
            to: Date.now
        )!
    }
    
    static func yesterday() -> Date {
        return Calendar.current.date(
            byAdding: .day,
            value: -1,
            to: Date.now
        )!
    }
    
    static func onWeekAgoStartOfDay() -> Date {
        Calendar.current.date(
            byAdding: .day,
            value: -7,
            to: DateUtils.startOfDate(for: Date.now)
        )!
    }
    
    static func startOfDate(for date: Date) -> Date {
        Calendar.current.date(from: Calendar.current.dateComponents([.year,.month,.day], from: date))!
    }
}

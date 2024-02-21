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
}

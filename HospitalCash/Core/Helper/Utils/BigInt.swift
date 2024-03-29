//
//  BigInt.swift
//  HospitalCash
//
//  Created by hschaeufler on 24.02.24.
//

import Foundation
import BigInt

extension BigInt {
    func toDate() -> Date {
        Date(timeIntervalSince1970: Double(String(self))!)
    }
}

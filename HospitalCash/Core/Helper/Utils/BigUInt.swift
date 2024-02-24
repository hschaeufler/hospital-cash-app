//
//  BigUInt.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 24.02.24.
//

import Foundation
import BigInt

extension BigUInt {
    func toDate() -> Date {
        Date(timeIntervalSince1970: Double(String(self))!)
    }
}

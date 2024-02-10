//
//  CommonError.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 31.01.24.
//

import Foundation


enum CommonError: Error {
    case dataCorrupted
    case couldNotParse
}

extension CommonError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .dataCorrupted:
            return "Read data is corrupted"
        case .couldNotParse:
            return "Could not parse Data"
        }
    }
}

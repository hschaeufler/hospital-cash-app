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
    case contractExecutionError(message: String)
    case accessDenied
}

extension CommonError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .dataCorrupted:
            return "Read data is corrupted"
        case .couldNotParse:
            return "Could not parse Data"
        case .contractExecutionError(let message):
            return message
        case .accessDenied:
            return "Access was denied."
        }
    }
}

//
//  LocalizedErrorStringExtension.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import Foundation

// see: https://www.hackingwithswift.com/example-code/language/how-to-throw-errors-using-strings
extension String: LocalizedError {
    public var errorDescription: String? { return self }
}

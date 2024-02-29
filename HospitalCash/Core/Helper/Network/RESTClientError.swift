//
//  RESTClientError.swift
//  HospitalCash
//
//  Created by hschaeufler on 29.01.23.
//  Source: https://github.com/hschaeufler/he4lth-app

import Foundation

enum RESTClientError: Error {
    case invalidURL
    case serverError(statusCode: Int)
    case invalidResponse
    case unauthorized
}

extension RESTClientError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Ungültige URL"
        case .serverError(let statusCode):
            return "Fehler bei der HTTP-Anfrage: Statuscode \(statusCode)"
        case .invalidResponse:
            return "Fehler beim Lesen der Response"
        case .unauthorized:
            return "Unauthorized"
        }
    }
}

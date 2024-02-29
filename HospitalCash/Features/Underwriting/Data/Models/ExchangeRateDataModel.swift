//
//  ExchangeRateDataModel.swift
//  HospitalCash
//
//  Created by hschaeufler on 31.01.24.
//

import Foundation



struct ExchangeRateDataModel: Decodable {
    var data: ExchangeRateData
    
    struct ExchangeRateData: Decodable {
        var currency: String
        var rates: [String: String]
    }
    
    enum CurrencyEnum: String {
        case EUR = "EUR"
        case ETH = "ETH"
        case UNKNOWN = "UNKNOWN"
    }
}

extension ExchangeRateDataModel.CurrencyEnum {
    static func fromRawValue(_ rawValue: String) -> ExchangeRateDataModel.CurrencyEnum {
        if let curencey = ExchangeRateDataModel.CurrencyEnum(rawValue: rawValue) {
            return curencey
        }
        return ExchangeRateDataModel.CurrencyEnum.UNKNOWN
    }
}

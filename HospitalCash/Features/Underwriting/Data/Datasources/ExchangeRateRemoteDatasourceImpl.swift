//
//  ExchangeRateRemoteDatasource.swift
//  HospitalCash
//
//  Created by hschaeufler on 31.01.24.
//

import Foundation

protocol ExchangeRateRemoteDatasource {
    func getExchangeRates(_ currency: ExchangeRateDataModel.CurrencyEnum) async throws -> ExchangeRateDataModel
}

class ExchangeRateRemoteDatasourceImpl: ExchangeRateRemoteDatasource {
    static let API_ENDPOINT  = "https://api.coinbase.com/v2/"
    static let PATH_EXCHANGE_RATE = "exchange-rates"
    static let CURRENCY_KEY = "currency"
    
    private let restClient: RESTClient
    
    init(restClient: RESTClient) {
        self.restClient = restClient
    }
    
    func getExchangeRates(
        _ currency: ExchangeRateDataModel.CurrencyEnum
    ) async throws -> ExchangeRateDataModel {
        return try await restClient.get(
            ExchangeRateRemoteDatasourceImpl.API_ENDPOINT,
            path: ExchangeRateRemoteDatasourceImpl.PATH_EXCHANGE_RATE,
            queryParams: [
                ExchangeRateRemoteDatasourceImpl.CURRENCY_KEY : currency.rawValue
            ]
        )
    }
}

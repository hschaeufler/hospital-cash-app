//
//  ExchangeRateRepositoryImpl.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 31.01.24.
//

import Foundation

class ExchangeRateRepositoryImp: ExchangeRateRepository {
    let remoteDatasource: ExchangeRateRemoteDatasource
    
    init(remoteDatasource: ExchangeRateRemoteDatasource) {
        self.remoteDatasource = remoteDatasource
    }

    func getEthInEur() async throws -> Double {
        let exchangeRate = try await remoteDatasource.getExchangeRates(
            ExchangeRateDataModel.CurrencyEnum.ETH
        )
        let euroKey = ExchangeRateDataModel.CurrencyEnum.EUR.rawValue
        let euroRate = exchangeRate.data.rates[euroKey]
        guard let euroRate = euroRate else {
            throw CommonError.dataCorrupted
        }
        guard let euroRate = Double(euroRate) else {
            throw CommonError.couldNotParse
        }
        return euroRate
    }
    
    func getEurInEth() async throws -> Double {
        let exchangeRate = try await remoteDatasource.getExchangeRates(
            ExchangeRateDataModel.CurrencyEnum.EUR
        )
        let ethKey = ExchangeRateDataModel.CurrencyEnum.ETH.rawValue
        let ethRate = exchangeRate.data.rates[ethKey]
        guard let ethRate = ethRate else {
            throw CommonError.dataCorrupted
        }
        guard let ethRate = Double(ethRate) else {
            throw CommonError.couldNotParse
        }
        return ethRate
    }
}

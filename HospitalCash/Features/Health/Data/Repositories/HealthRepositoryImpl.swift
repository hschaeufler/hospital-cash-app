//
//  HealthRepositoryImpl.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import Foundation
import HealthKit
import web3
import metamask_ios_sdk

class HealthRepositoryImpl: HealthRepository {
    let hkLocalDatasource: HKLocalDatasource
    let healthRemoteDatasource: HealthRemoteDatasource
    let walletLocalDatasource: WalletLocalDataSource
    
    init(
        hkLocalDatasource: HKLocalDatasource,
        healthRemoteDatasource: HealthRemoteDatasource,
        walletLocalDatasource: WalletLocalDataSource
    ) {
        self.hkLocalDatasource = hkLocalDatasource
        self.healthRemoteDatasource = healthRemoteDatasource
        self.walletLocalDatasource = walletLocalDatasource
    }

    func getTodayStepCount() async throws -> Double? {
       try await hkLocalDatasource.readTodaysSteps()?.sumQuantity()?.doubleValue(for: HKUnit.count())
    }
    
    func getWeeklySteps() async throws -> [StepDateCountEntity] {
        try await hkLocalDatasource.readWeeklySteps(with: nil).map { hkStatistic in
            hkStatistic.toStepDateCountEntity()
        }
    }
    
    func getLastPayoutDate() async throws -> Date {
        let contractAdress = healthRemoteDatasource.getContractAdress()
        let walletAddress = walletLocalDatasource.getWalletAdress()
        let model = GetLastPayOutDateRequestModel(contractAdress, from: EthereumAddress(walletAddress))
        let result = try await healthRemoteDatasource.getLastPayOutDate(with: model)
        return result.value.toDate()
    }
    
    func claimDiscount(
        with weeklyStepCount: [StepDateCountEntity]
    ) async throws -> String {
        let contractAdress = healthRemoteDatasource.getContractAdress()
        let walletAdress = walletLocalDatasource.getWalletAdress()
        do {
            let requestModel = try ClaimDiscountRequestModel.fromEntity(
                contractAdress,
                from: walletAdress,
                with: weeklyStepCount
            )
            return try await walletLocalDatasource.sendTransaction(with: requestModel)
        } catch let error as RequestError {
            throw try error.toCommonError()
        }
    }
}

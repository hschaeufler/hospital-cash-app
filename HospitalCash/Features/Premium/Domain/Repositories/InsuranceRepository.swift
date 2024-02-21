//
//  InsuranceRepository.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 09.02.24.
//

import Foundation

protocol InsuranceRepository {
    func getMonthlyPremium(with entity: PremiumCalculationEntity) async throws -> Double
    func checkBMI(heightInCm: Int, weightInKg: Int) async throws -> Bool
    func checkHealthQuestions(with entity: HealthQuestionEntity) async throws -> Bool
    func underwriteContract(with application: ContractApplicationEntity) async throws -> String
    func getTransactionState(with tx: String) async throws -> TransactionStateEntity
    func getContract() async throws -> InsuranceContractEntity?
    func connectWallet() async throws -> String
}

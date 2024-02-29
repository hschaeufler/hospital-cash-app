//
//  ContractRepository.swift
//  HospitalCash
//
//  Created by hschaeufler on 09.02.24.
//

import Foundation

protocol ContractRepository {
    func underwriteContract(with application: ContractApplicationEntity) async throws -> String
    func getContract() async throws -> ContractEntity?
    func getValidContract() async throws -> ContractEntity?
    func hasContract() async throws -> Bool
    func hasValidContract() async throws -> Bool
}

//
//  ConnectWallet.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 21.02.24.
//

import Foundation

protocol ConnectWallet {
    func callAsFunction() async throws -> String
}

struct ConnectWalletUseCase: ConnectWallet {
    private let insuranceRepository: InsuranceRepository
    
    init(insuranceRepository: InsuranceRepository) {
        self.insuranceRepository = insuranceRepository
    }
    
    func callAsFunction() async throws -> String {
        return try await insuranceRepository.connectWallet();
    }
}

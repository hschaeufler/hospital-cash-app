//
//  CheckHealthQuestionValidity.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 31.01.24.
//

import Foundation

protocol CheckHealthQuestionValidity {
    func callAsFunction(with healthQuestions: HealthQuestionEntity) async throws -> Bool
}

struct CheckHealthQuestionValidityUseCase: CheckHealthQuestionValidity {
    private let insuranceRepository: ContractRepository
    
    init(insuranceRepository: ContractRepository) {
        self.insuranceRepository = insuranceRepository
    }
    
    func callAsFunction(with healthQuestions: HealthQuestionEntity) async throws -> Bool {
        try await insuranceRepository.checkHealthQuestions(with: healthQuestions)
    }
}

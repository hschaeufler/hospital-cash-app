//
//  CheckHealthQuestionValidity.swift
//  HospitalCash
//
//  Created by hschaeufler on 31.01.24.
//

import Foundation

protocol CheckHealthQuestionValidity {
    func callAsFunction(with healthQuestions: HealthQuestionEntity) async throws -> Bool
}

struct CheckHealthQuestionValidityUseCase: CheckHealthQuestionValidity {
    private let premiumRepository: PremiumRepository
    
    init(premiumRepository: PremiumRepository) {
        self.premiumRepository = premiumRepository
    }
    
    func callAsFunction(with healthQuestions: HealthQuestionEntity) async throws -> Bool {
        try await premiumRepository.checkHealthQuestions(with: healthQuestions)
    }
}

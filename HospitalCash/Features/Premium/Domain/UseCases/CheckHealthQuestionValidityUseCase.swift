//
//  CheckHealthQuestionsAreValid.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 31.01.24.
//

import Foundation

protocol CheckHealthQuestionValidity {
    func callAsFunction(with: HealthQuestionEntity) -> Bool
}

struct CheckHealthQuestionValidityUseCase: CheckHealthQuestionValidity {
    func callAsFunction(with: HealthQuestionEntity) -> Bool {
        return false
    }
}

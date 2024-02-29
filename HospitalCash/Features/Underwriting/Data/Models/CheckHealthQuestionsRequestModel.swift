//
//  CheckHealthQuetionsRequestModel.swift
//  HospitalCash
//
//  Created by hschaeufler on 11.02.24.
//

import Foundation
import web3
import BigInt

struct CheckHealthQuestionsRequestModel: ABIFunction {
    public static let name = "checkHealthQuestions"
    public let gasPrice: BigUInt? = nil
    public let gasLimit: BigUInt? = nil
    public let contract: EthereumAddress
    public let from: EthereumAddress?=nil
    
    public let healthQuestions: HealthQuestionModel
    
    init(_ contract: EthereumAddress,
         healthQuestions: HealthQuestionModel
    ) {
        self.contract = contract
        self.healthQuestions = healthQuestions
    }
    
    public func encode(to encoder: web3.ABIFunctionEncoder) throws {
        try encoder.encode(healthQuestions)
    }
}

extension CheckHealthQuestionsRequestModel {
    static func fromEntity(
        _ contractAdress: EthereumAddress,
        with entity: HealthQuestionEntity
    ) -> CheckHealthQuestionsRequestModel {
        CheckHealthQuestionsRequestModel(
            contractAdress,
            healthQuestions: HealthQuestionModel.fromEntity(with: entity)
        )
    }
}

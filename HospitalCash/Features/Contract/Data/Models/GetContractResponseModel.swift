//
//  GetContractResponseModel.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 21.02.24.
//

import Foundation
import web3
import BigInt

struct GetContractResponseModel: ABIResponse {
    static var types: [ABIType.Type] { [Bool.self, ContractModel.self] }
    let isValid: Bool
    let insuranceContract: ContractModel
    
    public init?(values: [ABIDecoder.DecodedValue]) throws {
        self.isValid = try values[0].decoded()
        self.insuranceContract = try values[1].decoded()
    }
}

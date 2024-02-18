//
//  UnderwriteContractResponseModel.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 18.02.24.
//

import Foundation
import web3

struct UnderwriteContractResponseModel: ABIResponse {
    static var types: [ABIType.Type] { [InsuranceContractModel.self] }

    var contract: InsuranceContractModel

    init?(values: [ABIDecoder.DecodedValue]) throws {
        self.contract = try values[0].decoded()
    }
}

//
//  UnderwriteContractResponseModel.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 18.02.24.
//

import Foundation
import web3

struct UnderwriteContractResponseModel: ABIResponse, MulticallDecodableResponse {
    static var types: [ABIType.Type] { [InsuranceContractModel.self] }

    var value: InsuranceContractModel

    init?(values: [ABIDecoder.DecodedValue]) throws {
        self.value = try values[0].decoded()
    }
}

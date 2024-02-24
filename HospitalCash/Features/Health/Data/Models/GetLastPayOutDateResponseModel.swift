//
//  GetLastPayOutDateResponseModel.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 24.02.24.
//

import Foundation
import web3
import BigInt

struct GetLastPayOutDateResponseModel: ABIResponse {
    static var types: [ABIType.Type] { [BigUInt.self] }
    let value: BigUInt
    
    public init?(values: [ABIDecoder.DecodedValue]) throws {
        self.value = try values[0].decoded()
    }
}


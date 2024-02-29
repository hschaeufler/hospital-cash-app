//
//  GetValidContractRequestModel.swift
//  HospitalCash
//
//  Created by hschaeufler on 21.02.24.
//

import Foundation
import web3
import BigInt

struct GetValidContractRequestModel: ABIFunction {
    static let name = "getValidContract"
    let gasPrice: BigUInt? = nil
    let gasLimit: BigUInt? = nil
    let contract: EthereumAddress
    var from: EthereumAddress? = nil
    
    init(_ contract: EthereumAddress,
         from: EthereumAddress
    ) {
        self.contract = contract
        self.from = from
    }
    
    func encode(to encoder: web3.ABIFunctionEncoder) throws {}
}

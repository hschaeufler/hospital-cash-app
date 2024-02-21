//
//  GetContractRequestModel.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 21.02.24.
//

import Foundation
import web3
import BigInt

struct GetContractRequestModel: ABIFunction {
    static let name = "getContract"
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

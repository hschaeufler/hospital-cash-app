//
//  UnderwriteContractRequestModel.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 18.02.24.
//

import Foundation
import web3
import BigInt

struct UnderwriteContractRequestModel: ABIFunction {
    public static let name = "applyForInsurace"
    public var gasPrice: BigUInt? = nil
    public var gasLimit: BigUInt? = nil
    public var contract: EthereumAddress
    public var from: EthereumAddress?=nil
    
    public let value: BigUInt
    let contractApplication: ContractApplicationModel
    
    
    init(_ contract: EthereumAddress,
         from: EthereumAddress? = nil,
         value: BigUInt,
         contractApplication: ContractApplicationModel
    ) {
        self.contract = contract
        self.from = from
        self.value = value
        self.contractApplication = contractApplication
    }
    
    public func encode(to encoder: web3.ABIFunctionEncoder) throws {
        try encoder.encode(value)
        try encoder.encode(contractApplication)
    }
}

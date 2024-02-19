//
//  UnderwriteContractRequestModel.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 18.02.24.
//

import Foundation
import web3
import BigInt
import metamask_ios_sdk

struct UnderwriteContractRequestModel: CodableData {
    static let name = "applyForInsurace"
    let to: String
    let data: String
    let value: String
    
    
    init(_ contract: EthereumAddress,
         contractApplication: ContractApplicationModel,
         value: BigUInt
    ) throws {
        self.to = contract.asString()
        self.value = UnderwriteContractRequestModel.encodeValue(value)
        self.data = try UnderwriteContractRequestModel.encodeData(contractApplication)
    }
    
    private static func encodeData(_ contractApplication: ContractApplicationModel) throws -> String {
        let encoder = ABIFunctionEncoder(Self.name)
        try encoder.encode(contractApplication)
        return String(decoding: try encoder.encoded(), as: UTF8.self)
    }
    
    private static func encodeValue(_ value: BigUInt) -> String {
        return value.web3.hexString
    }
    
    func socketRepresentation() -> NetworkData {
           [
               "to": to,
               "value": value,
               "data": data
           ]
       }
}

extension UnderwriteContractRequestModel {
    static func fromEntity(
        _ contractAdress: EthereumAddress,
        with entity: ContractApplicationEntity,
        and yearlyPremiumInEth: Double
    ) throws -> UnderwriteContractRequestModel {
        let weiAmount = yearlyPremiumInEth * Double(EthUnits.wei)
        return try UnderwriteContractRequestModel(
            contractAdress,
            contractApplication: ContractApplicationModel.fromEntity(with: entity), 
            value: BigUInt(weiAmount)
        )
    }
}

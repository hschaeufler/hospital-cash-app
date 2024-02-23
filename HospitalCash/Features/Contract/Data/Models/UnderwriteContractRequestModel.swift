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
    let from: String
    let data: String
    let value: String
    
    
    init(_ contract: EthereumAddress,
         from: String,
         contractApplication: ContractApplicationModel,
         value: BigUInt
    ) throws {
        self.to = contract.asString()
        self.from = from
        self.value = UnderwriteContractRequestModel.encodeValue(value)
        print(self.value)
        self.data = try UnderwriteContractRequestModel.encodeData(contractApplication)
    }
    
    private static func encodeData(_ contractApplication: ContractApplicationModel) throws -> String {
        let encoder = ABIFunctionEncoder(Self.name)
        try encoder.encode(contractApplication)
        return try encoder.encoded().web3.hexString
    }
    
    private static func encodeValue(_ value: BigUInt) -> String {
        return value.web3.hexStringNoLeadingZeroes
    }
    
    func socketRepresentation() -> NetworkData {
           [
               "to": to,
               "from": from,
               "value": value,
               "data": data
           ]
       }
}

extension UnderwriteContractRequestModel {
    static func fromEntity(
        _ contractAdress: EthereumAddress,
        from: String,
        with entity: ContractApplicationEntity
    ) throws -> UnderwriteContractRequestModel {
        let weiAmount = entity.yearlyPremiumInEth * Double(EthUnits.wei)
        return try UnderwriteContractRequestModel(
            contractAdress,
            from: from,
            contractApplication: ContractApplicationModel.fromEntity(with: entity),
            value: BigUInt(weiAmount)
        )
    }
}

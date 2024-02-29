//
//  ClaimDiscountRequestModel.swift
//  HospitalCash
//
//  Created by hschaeufler on 24.02.24.
//

import Foundation
import web3
import BigInt
import metamask_ios_sdk

struct ClaimDiscountRequestModel: CodableData {
    static let name = "claimDiscount"
    let to: String
    let from: String
    let data: String
    
    
    init(_ contract: EthereumAddress,
         from: String,
         discountClaims: [StepDateCountModel]
    ) throws {
        self.to = contract.asString()
        self.from = from
        self.data = try ClaimDiscountRequestModel.encodeData(discountClaims)
    }
    
    private static func encodeData(_ discountClaims: [StepDateCountModel]) throws -> String {
        let encoder = ABIFunctionEncoder(Self.name)
        try encoder.encode(discountClaims)
        return try encoder.encoded().web3.hexString
    }
    
    func socketRepresentation() -> NetworkData {
           [
               "to": to,
               "from": from,
               "data": data
           ]
       }
}

extension ClaimDiscountRequestModel {
    static func fromEntity(
        _ contractAdress: EthereumAddress,
        from: String,
        with entity: [StepDateCountEntity]
    ) throws -> ClaimDiscountRequestModel {
        return try ClaimDiscountRequestModel(
            contractAdress,
            from: from,
            discountClaims: entity.map{ stepDateCountEntity in
                try StepDateCountModel.fromEntity(with: stepDateCountEntity)
            }
        );
    }
}

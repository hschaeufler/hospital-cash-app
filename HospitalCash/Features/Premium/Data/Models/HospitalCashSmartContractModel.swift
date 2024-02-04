//
//  HospitalCashSCModel.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 03.02.24.
//


import Foundation
import web3
import BigInt

enum HospitalCashSmartContractModel {
    struct getHospitalCashPremiumFunction: ABIFunction {
        public static let name = "getHospitalCashPremium"
        public let gasPrice: BigUInt? = nil
        public let gasLimit: BigUInt? = nil
        public let contract: EthereumAddress
        public let from: EthereumAddress?=nil
        
        public let birthDate: BigUInt
        public let insuranceStartDate: BigUInt
        public let hospitalCashInWei: BigUInt
        
        init(_ contract: EthereumAddress,
             birthDateTs: BigUInt,
             insuranceStartDateTs: BigUInt,
             hospitalCashInWei: BigUInt
        ) {
            self.contract = contract
            self.birthDate = birthDateTs
            self.insuranceStartDate = insuranceStartDateTs
            self.hospitalCashInWei = hospitalCashInWei
        }
        
        public func encode(to encoder: web3.ABIFunctionEncoder) throws {
            try encoder.encode(birthDate)
            try encoder.encode(insuranceStartDate)
            try encoder.encode(hospitalCashInWei)
        }
    }
    
    public struct getHospitalCashPremiumResponse: ABIResponse, MulticallDecodableResponse {
          public static var types: [ABIType.Type] = [BigUInt.self]
          public let value: BigUInt

          public init?(values: [ABIDecoder.DecodedValue]) throws {
              self.value = try values[0].decoded()
          }
      }
}

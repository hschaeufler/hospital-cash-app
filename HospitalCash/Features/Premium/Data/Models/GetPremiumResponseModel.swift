//
//  GetPremiumResponseModel.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 09.02.24.
//

import Foundation
import web3
import BigInt

public struct GetPremiumResponseModel: ABIResponse, MulticallDecodableResponse {
      public static var types: [ABIType.Type] = [BigUInt.self]
      public let value: BigUInt

      public init?(values: [ABIDecoder.DecodedValue]) throws {
          self.value = try values[0].decoded()
      }
  }

extension GetPremiumResponseModel {
    func toEth() -> Double? {
        let doubleValue = Double(String(self.value))! / Double(EthUnits.wei)
        return doubleValue
    }
}

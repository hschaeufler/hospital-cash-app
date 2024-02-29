//
//  GetMonthlyPremiumResponseModel.swift
//  HospitalCash
//
//  Created by hschaeufler on 09.02.24.
//

import Foundation
import web3
import BigInt

public struct GetMonthlyPremiumResponseModel: ABIResponse, MulticallDecodableResponse {
      public static var types: [ABIType.Type] = [BigUInt.self]
      public let value: BigUInt

      public init?(values: [ABIDecoder.DecodedValue]) throws {
          self.value = try values[0].decoded()
      }
  }

extension GetMonthlyPremiumResponseModel {
    func toEth() -> Double? {
        let doubleValue = Double(String(self.value))! / Double(EthUnits.wei)
        return doubleValue
    }
}

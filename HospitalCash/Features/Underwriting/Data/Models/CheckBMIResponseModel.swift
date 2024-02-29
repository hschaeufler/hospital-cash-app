//
//  CheckBMIResponseModel.swift
//  HospitalCash
//
//  Created by hschaeufler on 11.02.24.
//

import Foundation
import BigInt
import web3

public struct CheckBMIResponseModel: ABIResponse {
    public static var types: [ABIType.Type] { [BigUInt.self, Bool.self] }
      public let bmi: BigUInt
      public let isOk: Bool

      public init?(values: [ABIDecoder.DecodedValue]) throws {
          self.bmi = try values[0].decoded()
          self.isOk = try values[1].decoded()
      }
}

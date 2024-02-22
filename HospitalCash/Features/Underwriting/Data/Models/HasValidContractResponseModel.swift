//
//  HasValidContractResponseModel.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 22.02.24.
//

import Foundation
import web3

public struct HasValidContractResponseModel: ABIResponse {
      public static var types: [ABIType.Type] = [Bool.self]
      public let value: Bool

      public init?(values: [ABIDecoder.DecodedValue]) throws {
          self.value = try values[0].decoded()
      }
}

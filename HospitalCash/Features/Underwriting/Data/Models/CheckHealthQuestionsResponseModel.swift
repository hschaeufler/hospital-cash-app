//
//  CheckHealthQuestionsResponseModel.swift
//  HospitalCash
//
//  Created by hschaeufler on 11.02.24.
//

import Foundation
import web3

public struct CheckHealthQuestionsResponseModel: ABIResponse {
      public static var types: [ABIType.Type] = [Bool.self]
      public let value: Bool

      public init?(values: [ABIDecoder.DecodedValue]) throws {
          self.value = try values[0].decoded()
      }
}

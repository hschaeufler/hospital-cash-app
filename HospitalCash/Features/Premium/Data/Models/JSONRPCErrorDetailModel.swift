//
//  JSONRPCErrorDetailModel.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 11.02.24.
//

import Foundation
import web3

struct JSONRPCErrorDetailModel: ABIResponse, MulticallDecodableResponse {
      public static var types: [ABIType.Type] = [String.self]
      public let value: String

      public init?(values: [ABIDecoder.DecodedValue]) throws {
          self.value = try values[0].decoded()
      }
  }

extension JSONRPCErrorDetail {
    func toCommonError() throws -> CommonError {
        let dataString = self.data?.data ?? "";
        // see: https://stackoverflow.com/questions/71686139/the-web3-json-rpc-error-message-is-not-clearly-how-to-decode-it
        let errorMethodSignature = "0x08c379a0";
        let data = dataString.replacingOccurrences(of: errorMethodSignature, with: "")
        let errorModel = try JSONRPCErrorDetailModel(data: data)
        return CommonError.contractExecutionError(message: errorModel?.value ?? self.message)
    }
}

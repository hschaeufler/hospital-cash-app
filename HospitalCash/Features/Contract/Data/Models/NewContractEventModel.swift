//
//  NewContractEventModel.swift
//  HospitalCash
//
//  Created by hschaeufler on 21.02.24.
//

import Foundation
import web3
import BigInt

struct NewContractEventModel: ABIEvent {
    static let name = "NewContract"
    static let types: [ABIType.Type] = [
        EthereumAddress.self,
        BigUInt.self,
        BigUInt.self,
        BigUInt.self,
        BigUInt.self,
    ]
    static let typesIndexed = [true, false, false, false, false]
    let log: EthereumLog

    public let policyHolder: EthereumAddress
    public let policyId: BigUInt
    public let insuranceStartDate: BigUInt
    public let insuranceEndDate: BigUInt
    public let dailyHospitalCashInWei: BigUInt

    public init?(topics: [ABIDecoder.DecodedValue], data: [ABIDecoder.DecodedValue], log: EthereumLog) throws {
        try NewContractEventModel.checkParameters(topics, data)
        self.log = log

        self.policyHolder = try topics[0].decoded()
        self.policyId = try data[0].decoded()
        self.insuranceStartDate = try data[1].decoded()
        self.insuranceEndDate = try data[2].decoded()
        self.dailyHospitalCashInWei = try data[3].decoded()
    }
}

extension NewContractEventModel {
    func toEntity() -> NewContractEventEntity {
       return NewContractEventEntity(
        policyId: Int(String(self.policyId))!,
        insuranceStartDate: Date(timeIntervalSince1970: Double(String(self.insuranceStartDate))!),
        insuranceEndDate: Date(timeIntervalSince1970: Double(String(self.insuranceEndDate))!),
        dailyHospitalCash: Double(String(self.dailyHospitalCashInWei))! / Double(EthUnits.wei)
       )
    }
}

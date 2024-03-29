//
//  ContractDetailGroup.swift
//  HospitalCash
//
//  Created by hschaeufler on 20.02.24.
//

import SwiftUI

struct ContractDetailGroup: View {
    var insuranceContract: ContractEntity
    
    var body: some View {
        List {
            Group {
                    Text("Deine Informationen")
                        .multilineTextAlignment(.leading)
                        .font(.title2)
                        .bold()
                .padding(.bottom, 5)
                OutputFloatingPointField(
                    titleKey: "Versicherungsnummer",
                    caption: "Diese musst du bei einem Krankenhausaufenthalt angeben.",
                    number: Double(insuranceContract.policyId),
                    style: OutputFloatingPointField.FieldStyle.multiLine,
                    allowCopy: true
                )
                OutputFloatingPointField(
                    titleKey: "Höhe Krankenhaustageld",
                    number: insuranceContract.dailyHospitalCash,
                    unit: "ETH",
                    style: OutputFloatingPointField.FieldStyle.multiLine,
                    allowCopy: true
                )
                OutputDateRangeField(
                    titleKey: "Zeitraum",
                    caption:  "Deine Versicherung ist 1 Jahr gültig und kann am Ende der Laufzeit verlängert werden.",
                    startDate: insuranceContract.insuranceStartDate,
                    endDate: insuranceContract.insuranceEndDate,
                    allowCopy: true
                )
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    ContractDetailGroup(
    insuranceContract: ContractEntity(
        policyId: 12334,
        insuranceStartDate: Date(),
        insuranceEndDate: Date(),
        dailyHospitalCash: 1222,
        paidPremium: 1222,
        lastPayoutDate: Date(),
        birthdate: Date()
    )
    )
}

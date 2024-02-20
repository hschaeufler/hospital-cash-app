//
//  ContractDetailPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 19.02.24.
//

import SwiftUI

struct ContractDetailPage: View {
    var body: some View {
        SheetPageLayout("Deine Versicherung") {
            VStack {
                Spacer()
                Image(systemName: "fireworks")
                    .font(.system(size: 90))
                    .foregroundStyle(.green, .blue)
                Text("Gratulation zum \nerfolgreichen Abschluss!")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .bold()
                CustomDivider(maxWidth: 150)
                    .padding(.vertical, 10)
                List {
                    Group {
                        Text("Deine Informationen")
                            .multilineTextAlignment(.leading)
                            .font(.title2)
                            .bold()
                        OutputFloatingPointField(
                            titleKey: "Versicherungsnummer",
                            caption: "Diese musst du bei einem Krankenhausaufenthalt angeben.",
                            number: 2,
                            style: OutputFloatingPointField.FieldStyle.multiLine,
                            allowCopy: true
                        )
                        OutputFloatingPointField(
                            titleKey: "Höhe Krankenhaustaggeld",
                            number: 0.5,
                            unit: "ETH",
                            style: OutputFloatingPointField.FieldStyle.multiLine,
                            allowCopy: true
                        )
                        OutputDateRangeField(
                            titleKey: "Zeitraum",
                            caption:  "Deine Versicherung ist 1 Jahr gültig und kann am Ende der Laufzeit verlängert werden.",
                            startDate: Date(),
                            endDate: Date(),
                            allowCopy: true
                        )
                    }
                }
                .listStyle(.plain)
                Spacer()
                BorderedButton("Zur Übersicht") {}
            }
        }
    }
}

#Preview {
    ContractDetailPage()
}

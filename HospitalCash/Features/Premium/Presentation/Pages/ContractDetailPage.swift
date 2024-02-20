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
            VStack(spacing: 15) {
                Spacer()
                Image(systemName: "fireworks")
                    .font(.system(size: 90))
                    .foregroundStyle(.green, .blue)
                Text("Gratulation zum \nerfolgreichen Abschluss!")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .bold()
                CustomDivider(maxWidth: 150)
                Text("Deine Informationen")
                    .multilineTextAlignment(.center)
                    .font(.title2)
                    .bold()
                OutputFloatingPointField(
                    titleKey: "Versicherungsnummer",
                    number: 2
                )
                InfoBox("Versicherungsnummer", contentKey: "Diese musst du bei einem Krankenhausaufenthalt angeben.")
                OutputFloatingPointField(
                    titleKey: "Höhe Krankenhaustaggeld",
                    number: 0.5,
                    unit: "ETH"
                )
                HStack {
                    DatePicker(
                        "",
                        selection: .constant(Date()),
                        displayedComponents: [.date]
                    )
                    .disabled(true)
                    Spacer()
                    Text(" - ")
                    Spacer()
                    DatePicker(
                        "",
                        selection: .constant(Date()),
                        displayedComponents: [.date]
                    )
                    .disabled(true)
                }
                InfoBox("Laufzeit", contentKey: "Deine Versicherung ist 1 Jahr gültig und kann am Ende der Laufzeit verlängert werden.")
                Spacer()
                BorderedButton("Zur Übersicht") {}
            }
        }
    }
}

#Preview {
    ContractDetailPage()
}

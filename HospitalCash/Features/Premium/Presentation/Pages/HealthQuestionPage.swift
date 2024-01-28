//
//  HealthQuestionPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 27.01.24.
//

import SwiftUI

struct HealthQuestionPage: View {
    @State private var hasInpatientTreatment = false;

    var body: some View {
        VStack {
            Form {
                Section {
                    InfoToggle(
                        "Stationäre Behandlung",
                        contentKey: "GESUNDHEITSFRAGE_STATIONAERE_BEHANDLUNG",
                        systemImage: "bed.double",
                        isOn: $hasInpatientTreatment
                    )
                    InfoToggle(
                        "Ambulante Behandlung",
                        contentKey: "GESUNDHEITSFRAGE_AMBULANTE_BEHANDLUNG",
                        systemImage: "cross.case",
                        isOn: $hasInpatientTreatment
                    )
                    InfoToggle(
                        "Psychoterapie",
                        contentKey: "GESUNDHEITSFRAGE_PSYCHOTHERAPIE",
                        systemImage: "brain",
                        isOn: $hasInpatientTreatment
                    )
                    InfoToggle(
                        "Chronische Erkrankung",
                        contentKey: "GESUNDHEITSFRAGE_CHRONISCHE_ERKRANKUNG",
                        systemImage: "staroflife",
                        isOn: $hasInpatientTreatment
                    )
                    InfoToggle(
                        "Medikamenteneinahme",
                        contentKey: "GESUNDHEITSFRAGE_MEDIKAMENTE",
                        systemImage: "cross.vial",
                        isOn: $hasInpatientTreatment
                    )
                }
            }
            NavigationLinkButton("Weiter") {
                HealthQuestionPage()
            }
        }
        .navigationTitle("Gesundheitsfragen")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    HealthQuestionPage()
}

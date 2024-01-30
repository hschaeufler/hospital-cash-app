//
//  HealthQuestionPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 27.01.24.
//

import SwiftUI

struct HealthQuestionPage: View {
    @State private var hasInpatientTreatment = false;
    @State private var hasOutpatientTreatment = false;
    @State private var hasPsychotherapy = false;
    @State private var hasChronicIllness = false;
    @State private var hasMedication = false;

    var body: some View {
        SheetPageLayout("Gesundheitsfragen") {
            VStack {
                Form {
                    Section {
                        InfoBox("Gesundheitsfragen", contentKey: "Bitte bestäge einzeln, dass keiner der nachfolgenden Fälle dich betrifft.")
                            .backgroundStyle(.windowBackground)
                            .listRowInsets(EdgeInsets())
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
                            isOn: $hasOutpatientTreatment
                        )
                        InfoToggle(
                            "Psychoterapie",
                            contentKey: "GESUNDHEITSFRAGE_PSYCHOTHERAPIE",
                            systemImage: "brain",
                            isOn: $hasPsychotherapy
                        )
                        InfoToggle(
                            "Chronische Erkrankung",
                            contentKey: "GESUNDHEITSFRAGE_CHRONISCHE_ERKRANKUNG",
                            systemImage: "staroflife",
                            isOn: $hasChronicIllness
                        )
                        InfoToggle(
                            "Medikamenteneinahme",
                            contentKey: "GESUNDHEITSFRAGE_MEDIKAMENTE",
                            systemImage: "cross.vial",
                            isOn: $hasMedication
                        )
                    }
                }
                NavigationLinkButton("Weiter") {
                    PremiumCalculationPage()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HealthQuestionPage()
    }
}

//
//  HealthQuestionPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 27.01.24.
//

import SwiftUI

struct HealthQuestionPage: View {
    @Environment(PremiumCalculationVM.self) private var premiumCalculationVm
    
    @State private var hasInpatientTreatment = false;
    @State private var hasOutpatientTreatment = false;
    @State private var hasPsychotherapy = false;
    @State private var hasChronicIllness = false;
    @State private var hasMedication = false;

    var body: some View {
        @Bindable var premiumCalculationVm = premiumCalculationVm
        let healthQuestions = $premiumCalculationVm.healthQuestions
        
        SheetPageLayout("Gesundheitsfragen") {
            VStack {
                Form {
                    Section {
                        InfoBox("Gesundheitsfragen", contentKey: "Bitte bestätige einzeln, dass keiner der nachfolgenden Fälle dich betrifft.")
                            .backgroundStyle(.windowBackground)
                            .listRowInsets(EdgeInsets())
                        InfoToggle(
                            "Stationäre Behandlung",
                            contentKey: "GESUNDHEITSFRAGE_STATIONAERE_BEHANDLUNG",
                            systemImage: "bed.double",
                            isOn: healthQuestions.hasNoInpatientTreatment
                        )
                        InfoToggle(
                            "Ambulante Behandlung",
                            contentKey: "GESUNDHEITSFRAGE_AMBULANTE_BEHANDLUNG",
                            systemImage: "cross.case",
                            isOn: healthQuestions.hasNoOutpatientTreatment
                        )
                        InfoToggle(
                            "Psychoterapie",
                            contentKey: "GESUNDHEITSFRAGE_PSYCHOTHERAPIE",
                            systemImage: "brain",
                            isOn: healthQuestions.hasNoPsychotherapy
                        )
                        InfoToggle(
                            "Chronische Erkrankung",
                            contentKey: "GESUNDHEITSFRAGE_CHRONISCHE_ERKRANKUNG",
                            systemImage: "staroflife",
                            isOn: healthQuestions.hasNoChronicIllness
                        )
                        InfoToggle(
                            "Medikamenteneinahme",
                            contentKey: "GESUNDHEITSFRAGE_MEDIKAMENTE",
                            systemImage: "cross.vial",
                            isOn: healthQuestions.hasNoMedication
                        )
                    }
                }
                NavigationLinkButton("Weiter", value: NavigationDestination.premiumCalculation)
                    .disabled(!premiumCalculationVm.areHealthQuestionsValid)
            }
        }
    }
}

#Preview {
    NavigationStack {
        HealthQuestionPage()
            .environment(PremiumCalculationVM())
    }
}

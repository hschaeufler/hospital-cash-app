//
//  HealthQuestionPage.swift
//  HospitalCash
//
//  Created by hschaeufler on 27.01.24.
//

import SwiftUI

struct HealthQuestionPage: View {
    @Environment(UnderwritingViewModel.self) private var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        let healthQuestions = $viewModel.healthQuestions
        
        UnderwritingSheetLayout("Gesundheitsfragen") {
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
                .onChange(of: viewModel.healthQuestions, {
                    Task {
                        await viewModel.checkHealthQuestions()
                    }
                })
                NavigationLinkButton("Weiter", value: UnderwritingViewModel.Destination.premiumCalculation)
                    .disabled(!viewModel.areHealthQuestionsValid)
            }
        }
    }
}

#Preview {
    NavigationStack {
        HealthQuestionPage()
            .environment(UnderwritingViewModel())
            .environment(WalletViewModel())
    }
}

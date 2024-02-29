//
//  PremiumCalculationPage.swift
//  HospitalCash
//
//  Created by hschaeufler on 28.01.24.
//

import SwiftUI

struct PremiumCalculationPage: View {
    @Environment(UnderwritingViewModel.self) private var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        UnderwritingSheetLayout("Beitrag berechnen") {
            VStack {
                Form {
                    NumberField("Höhe Krankenhaustagegeld",
                                caption: "Welchen Betrag möchtest du tgl. bei einem Krankenhausaufenthalt erhalten?",
                                number:  $viewModel.amountHospitalCashEur,
                                unit: "€",
                                range: 0...250,
                                step: 10,
                                style: NumberField.FieldStyle.multiLine
                    ).onChange(of: viewModel.amountHospitalCashEur) { oldValue, newValue in
                        Task {
                            await viewModel.calculateEurInEth()
                        }
                    }
                    OutputFloatingPointField(
                        titleKey: "tats. Betrag",
                        number: viewModel.amountHospitalCashEth,
                        unit: "ETH"
                    )
                    InfoBox("Hinweis", contentKey: "Die Krankenhaustagegeldhöhe wird in ETH versichert und ausgezahlt. Der EUR Betrag dient als Richtwert. Es besteht das Risiko von Wechselkursschwankungen.")
                        .backgroundStyle(.windowBackground)
                        .listRowInsets(EdgeInsets())
                    DatePicker(
                        "Versicherungsbeginn",
                        selection: $viewModel.insuranceStartDate,
                        in: viewModel.fromTomorrowRange,
                        displayedComponents: [.date]
                    )
                    .bold()
                    DatePicker(
                        "Geburtsdatum",
                        selection: $viewModel.birthDate,
                        in: viewModel.untilYesterdayRange,
                        displayedComponents: [.date]
                    )
                    .bold()
                }
                BorderedButton("Beitrag berechnen") {
                    Task {
                        await viewModel.caculatePremium()
                    }
                }
                .disabled(!viewModel.isCalculationAllowed)
            }
        }
    }
}

#Preview {
    PremiumCalculationPage()
        .environment(UnderwritingViewModel())
        .environment(WalletViewModel())
}

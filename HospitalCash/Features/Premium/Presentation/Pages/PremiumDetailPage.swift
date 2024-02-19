//
//  PremiumDetailPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 30.01.24.
//

import SwiftUI

struct PremiumDetailPage: View {
    @Environment(PremiumCalculationVM.self) private var viewModel
    @State private var showSheet = false
    
    var body: some View {
        let premium = viewModel.premiumEntity
        
        SheetPageLayout("Dein Beitrag") {
            VStack {
                Spacer()
                Image(systemName: "dollarsign.arrow.circlepath")
                    .font(.system(size: 90))
                    .foregroundStyle(.green, .blue)
                Spacer()
                PremiumDetailGroup(
                    yearlyPremiumEth: premium?.yearlyEthPremium ?? 0,
                    yearlyPremiumEur: premium?.yearlyEurPremium ?? 0,
                    hcAmountEth: viewModel.amountHospitalCashEth,
                    hcAmountEur: Double(viewModel.amountHospitalCashEur)
                )
                Spacer()
                CustomDivider(maxWidth: 150)
                Spacer()
                InsuranceAdvantagesColumn()
                    .scaledToFit()
                    .padding(.horizontal, 5)
                Spacer()
                BorderedButton("Jetzt abschließen") {
                    showSheet.toggle()
                }
            }
            .task {
                await viewModel.caculatePremium()
            }
            .sheet(isPresented: $showSheet, content: {
                NavigationStack {
                    PayWithMetamaskPage()
                        .environment(viewModel)
                }
                .presentationDetents([.fraction(1 / 3)])
                .presentationDragIndicator(.visible)
            })
            
        }
    }
}

#Preview {
    PremiumDetailPage()
        .environment(PremiumCalculationVM())
}

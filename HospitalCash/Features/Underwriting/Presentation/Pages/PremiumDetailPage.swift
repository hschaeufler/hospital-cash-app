//
//  PremiumDetailPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 30.01.24.
//

import SwiftUI

struct PremiumDetailPage: View {
    @Environment(UnderwritingVM.self) private var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
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
                    .padding(.horizontal, 5)
                Spacer()
                BorderedButton("Jetzt abschließen") {
                    viewModel.showConnectSheet.toggle()
                }
            }
            
        }
        .sheet(isPresented: $viewModel.showConnectSheet) {
            NavigationStack {
                PayWithMetamaskPage(isPayment: false)
                    .environment(viewModel)
            }
            .presentationDetents([.fraction(1 / 3)])
            .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $viewModel.showPaymentSheet) {
            NavigationStack {
                PayWithMetamaskPage(isPayment: true)
                    .environment(viewModel)
            }
            .presentationDetents([.fraction(1 / 3)])
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    PremiumDetailPage()
        .environment(UnderwritingVM())
}
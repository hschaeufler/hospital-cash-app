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
        let premium = viewModel.premiumEntity
        @Bindable var viewModel = viewModel
        
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
                    Task {
                        await viewModel.handleShowWallet()
                    }
                }
            }
            .sheet(isPresented: $viewModel.showConnectSheet) {
                ConnectWithWalletPage {
                    Task {
                        await viewModel.handleConnectWallet()
                    }
                }
            }
            .sheet(isPresented: $viewModel.showPaymentSheet) {
                PayWithWalletPage {
                    Task {
                        await viewModel.handleUnderwriteContract()
                    }
                }
            }
        }
    }
}

#Preview {
    PremiumDetailPage()
        .environment(UnderwritingVM())
        .environment(WalletVM())
}

//
//  PremiumDetailPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 30.01.24.
//

import SwiftUI

struct PremiumDetailPage: View {
    @Environment(PremiumCalculationVM.self) private var viewModel
    
    var body: some View {
        SheetPageLayout("Dein Beitrag") {
            VStack {
                Spacer()
                Image(systemName: "dollarsign.arrow.circlepath")
                    .font(.system(size: 90))
                    .foregroundStyle(.green, .blue)
                Spacer()
                Text("\(viewModel.amountHospitalCashEth.formatted()) Eth / ~ \(viewModel.amountHospitalCashEur.formatted()) €")
                    .foregroundStyle(.green)
                    .font(.title2)
                    .bold()
                Text("Krankenhaustagegeld")
                    .font(.title)
                    .bold()
                Text("für nur")
                    .font(.title2)
                    .bold()
                Text("\((viewModel.calculatedPremium?.yearlyEthPremium ?? 0).formatted()) Eth / ~ \((viewModel.calculatedPremium?.yearlyEurPremium ?? 0).formatted()) €")
                    .foregroundStyle(.green)
                    .font(.title2)
                    .bold()
                Text("pro Jahr")
                    .font(.title2)
                    .bold()
                Spacer()
                CustomDivider(maxWidth: 150)
                InsuranceAdvantagesColumn()
                    .scaledToFit()
                    .padding(.horizontal, 5)
                Spacer()
                NavigationLinkButton("Jetzt abschließen") {
                    PremiumDetailPage()
                }
            }
            .task {
                await viewModel.caculatePremium()
            }
            
        }
    }
}

#Preview {
    PremiumDetailPage()
        .environment(PremiumCalculationVM())
}

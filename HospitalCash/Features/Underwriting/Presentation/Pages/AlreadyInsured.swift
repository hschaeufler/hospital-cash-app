//
//  AlreadyInsured.swift
//  HospitalCash
//
//  Created by hschaeufler on 22.02.24.
//

import SwiftUI

struct AlreadyInsured: View {
    @Environment(WalletViewModel.self) private var walletVM
    
    var body: some View {
        UnderwritingSheetLayout("Bereits versichert?") {
            VStack {
                Spacer()
                Image(systemName: "person.fill.questionmark")
                    .font(.system(size: 90))
                    .foregroundStyle(.green, .blue)
                Text("Sie sind bereits versichert!")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .bold()
                CustomDivider(maxWidth: 150)
                    .padding(.vertical, 10)
                InfoBox("Hinweis", contentKey: "Sie haben bereits einen Vertrag unter dieser Adresse abgeschlossen. Kehren Sie zur Übersicht zurück um diesen zu Verwalten.")
                Spacer()
                BorderedButton("Zur Übersicht") {
                    Task {
                        await walletVM.fetchAppState()
                    }
                }
            }
        }
    }
}

#Preview {
    AlreadyInsured()
        .environment(WalletViewModel())
}

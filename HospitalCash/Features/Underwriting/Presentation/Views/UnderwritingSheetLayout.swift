//
//  UnderwritingSheetPageLayout.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 22.02.24.
//

import SwiftUI

struct UnderwritingSheetLayout<Content>: View where Content: View {
    @Environment(WalletViewModel.self) private var walletVM
    
    var titleKey: LocalizedStringKey
    @ViewBuilder let content: () -> Content
    
    init(_ titleKey: LocalizedStringKey,
         content: @escaping () -> Content
    ) {
        self.titleKey = titleKey
        self.content = content
    }
    
    var body: some View {
        SheetLayout(titleKey, dismiss: walletVM.handleDismiss, content: content)
    }
}

#Preview {
    UnderwritingSheetLayout("Test") {
        Text("Test123")
    }
    .environment(WalletViewModel())
}

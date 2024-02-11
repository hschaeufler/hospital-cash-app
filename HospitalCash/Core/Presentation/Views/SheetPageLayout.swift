//
//  SheetPageLayout.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 30.01.24.
//

import SwiftUI

struct SheetPageLayout<Content> : View where Content : View  {
    var titleKey: LocalizedStringKey
    @ViewBuilder let content: () -> Content
    
    @Environment(\.dismiss) private var dismiss
    
    init(_ titleKey: LocalizedStringKey, content: @escaping () -> Content) {
        self.titleKey = titleKey
        self.content = content
    }

    
    var body: some View {
        content()
            .navigationTitle(titleKey)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    CloseButton {
                        dismiss()
                    }
                }
            }
    }
}

#Preview {
    SheetPageLayout("BMI") {
        Text("Testpage")
    }
}

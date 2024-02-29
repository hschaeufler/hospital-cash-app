//
//  SheetPageLayout.swift
//  HospitalCash
//
//  Created by hschaeufler on 30.01.24.
//

import SwiftUI

struct SheetLayout<Content> : View where Content : View  {
    var titleKey: LocalizedStringKey
    var dismiss: () -> Void
    @ViewBuilder let content: () -> Content
    
    init(_ titleKey: LocalizedStringKey,
         dismiss: @escaping () -> Void,
         content: @escaping () -> Content) {
        self.titleKey = titleKey
        self.dismiss = dismiss
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
    SheetLayout("BMI", dismiss: {}) {
        Text("Testpage")
    }
}

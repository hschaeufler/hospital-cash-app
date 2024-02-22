//
//  ErrorViewBuilder.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 22.02.24.
//

import SwiftUI

struct ErrorViewBuilder<Content>: View where Content : View {
    var titleKey: LocalizedStringKey
    @ViewBuilder var content: () -> Content
    var error: () -> LocalizedStringKey?
    var retryAction: (() -> Void)?

    private var isPresented: Binding<Bool> {
        Binding(get: {
            error() != nil
        }, set: {_ in })
    }
    
    var body: some View {
        content()
            .alert(
                titleKey,
                isPresented: isPresented,
                presenting: error()
            ) { error in
                Button("OK", role: .cancel) {
                    retryAction?()
                }
            } message: { error in
                Text(error)
            }
    }
}

#Preview {
    ErrorViewBuilder(titleKey: "Fehler") {
        Text("Home")
    } error: {
        "Error Message"
    }
}

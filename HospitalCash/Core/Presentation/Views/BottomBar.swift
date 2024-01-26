//
//  BottomBar.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 26.01.24.
//

import SwiftUI

struct BottomBar<Content>: View where Content : View {
    @ScaledMetric var maxHeightButtonGroup = 100
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(.systemGray5))
                .ignoresSafeArea()
                .frame(maxHeight: maxHeightButtonGroup)
            content()
        }
    }
}

#Preview {
    BottomBar {
        FilledButton("Jetzt Beitrag berechnen") {}
    }
}

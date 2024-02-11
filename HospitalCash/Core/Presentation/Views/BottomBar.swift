//
//  BottomBar.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 26.01.24.
//

import SwiftUI

struct BottomBar<Content>: View where Content : View {
    var verticalPadding: CGFloat?
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(.systemGray5))
                .ignoresSafeArea()
            content()
                .padding(.vertical, verticalPadding)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    BottomBar {
        ProminentButton("Jetzt Beitrag berechnen") {}
    }
}

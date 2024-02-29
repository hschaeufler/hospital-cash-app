//
//  BorderedInkwell.swift
//  HospitalCash
//
//  Created by hschaeufler on 23.02.24.
//

import SwiftUI

struct BorderedInkwell<Content>: View where Content: View {
    var action: () -> Void
    @ViewBuilder var content: () -> Content
    
    
    var body: some View {
        Button ( action: action)  {
            content()
                .padding(5)
                .background {
                    RoundedRectangle(
                        cornerRadius: 10,
                        style: .continuous
                    )
                    .stroke(.gray, lineWidth: 1.0)
                }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    BorderedInkwell  {
        
    } content: {
        Text("test")
    }
}

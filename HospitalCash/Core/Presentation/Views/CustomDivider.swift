//
//  CustomDivider.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 26.01.24.
//

import SwiftUI

struct CustomDivider: View {
    var maxWidth: CGFloat
    
    var body: some View {
        Divider()
            .frame(maxWidth: maxWidth)
    }
}

#Preview {
    CustomDivider(maxWidth: 150)
}

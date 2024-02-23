//
//  ProgessCard.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import SwiftUI

struct ProgessCard: View {
    var body: some View {
        VStack(alignment: .center) {
            ProgressView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            RoundedRectangle(
                cornerRadius: 10,
                style: .continuous
            )
            .stroke(.gray, lineWidth: 1.0)
        }
    }
}

#Preview {
    ProgessCard()
}

//
//  ClaimDiscountCard.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 24.02.24.
//

import SwiftUI

struct ClaimDiscountCard: View {
    var action: () -> Void
    
    
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: "arrow.triangle.2.circlepath.icloud.fill")
                .font(.largeTitle)
            Text("Rabatt beantragen")
                .font(.title2)
                .bold()
            Text("Rabatt für die letzten 7 Tage beantragen. Achtung es können Transaktionsgebühren anfallen.")
                .multilineTextAlignment(.center)
                .font(.title3)
            Divider()
            Button (action: action) {
                Label("Erneut versuchen", systemImage: "icloud.and.arrow.up")
            }
            .buttonStyle(.bordered)
            .font(.title2)
            
        }
        .padding()
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
    ClaimDiscountCard() {}
}

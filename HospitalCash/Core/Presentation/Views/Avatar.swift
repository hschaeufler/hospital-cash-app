//
//  Avatar.swift
//  HospitalCash
//
//  Created by hschaeufler on 26.01.24.
//

import SwiftUI

struct Avatar: View {
    @ScaledMetric var padding = 10
    
    var systemName: String
    
    var body: some View {
        Image(systemName: systemName)
            .foregroundColor(.white)
            .padding(padding)
            .background {
                Circle()
                    .fill(Color(.blue))
            }
    }
}

#Preview {
    Avatar(systemName: "bed.double.circle")
        .font(.title)
}

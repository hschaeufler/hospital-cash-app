//
//  Avatar.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 26.01.24.
//

import SwiftUI

struct Avatar: View {
    @ScaledMetric var padding = 15
    
    var systemName: String
    
    var body: some View {
        Image(systemName: systemName)
            .resizable()
            .aspectRatio(contentMode: .fit)
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
}

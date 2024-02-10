//
//  HospitalCashLogo.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 26.01.24.
//

import SwiftUI

struct HospitalCashLogo: View {
    var body: some View {
        VStack {
            Image(systemName: "cross.case.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.tint)
                .frame(maxWidth: 75)
            Text("Hospital Cash")
                .font(.largeTitle)
                .fontDesign(.serif)
        }
    }
}

#Preview {
    HospitalCashLogo()
}

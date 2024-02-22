//
//  LoadingPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 22.02.24.
//

import SwiftUI

struct LoadingPage: View {
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
}

#Preview {
    LoadingPage()
}

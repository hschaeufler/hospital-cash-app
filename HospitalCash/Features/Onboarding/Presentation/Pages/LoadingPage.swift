//
//  LoadingPage.swift
//  HospitalCash
//
//  Created by hschaeufler on 22.02.24.
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

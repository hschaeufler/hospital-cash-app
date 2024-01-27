//
//  BMIPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 26.01.24.
//

import SwiftUI

struct BMIPage: View {
    var body: some View {
        VStack {
            Spacer()
            BottomBar {
                NavigationLink {
                    HealthQuestionPage()
                } label: {
                    Text("Next")
                }
                .buttonStyle(.bordered)
            }
        }
        .navigationTitle("BMI")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    BMIPage()
}

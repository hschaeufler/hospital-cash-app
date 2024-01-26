//
//  ContentView.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 26.01.24.
//

import SwiftUI

struct ContentView: View {
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
            Divider()
            Text("Unser neues Krankentagegeld auf Blockchain-Basis. Jetzt abschließen und von besonders günstigen Preisen profitieren.")
                .font(.title2)
                .multilineTextAlignment(.center)
            Divider()
            Text("Deine Vorteile")
                .font(.title2)
                .bold()
            Spacer()
            Button {} label: {
                Text("Jetzt Beitrag berechnen")
                    .font(.title3)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
            }
            .buttonStyle(.bordered)
            .tint(.blue)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

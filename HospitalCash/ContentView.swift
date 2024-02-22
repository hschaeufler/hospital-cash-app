//
//  ContentView.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 26.01.24.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = WalletVM()
    
    var body: some View {
        if !viewModel.isReady {
            VStack(alignment: .center) {
                Spacer()
                ProgressView()
                Spacer()
            }
            .task {
                await viewModel.hasContract()
            }
        } else if viewModel.hasContract {
            HomePage()
        } else {
            WelcomePage()
                .environment(viewModel)
        }
    }
}

#Preview {
    ContentView()
}

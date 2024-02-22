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
        switch viewModel.state {
        case .loading:
            LoadingPage()
                .onAppear() {
                    Task {
                        await viewModel.fetchAppState()
                    }
                }
        case .hasContract:
            HomePage()
                .environment(viewModel)
        default:
            WelcomePage()
                .environment(viewModel)
        }
    }
}

#Preview {
    ContentView()
}

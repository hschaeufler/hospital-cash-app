//
//  ContentView.swift
//  HospitalCash
//
//  Created by hschaeufler on 26.01.24.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = WalletViewModel()
    
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

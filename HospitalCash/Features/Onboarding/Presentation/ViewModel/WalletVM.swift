//
//  WalletViewModel.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 21.02.24.
//

import Foundation
import Factory

@Observable class WalletVM {
    @ObservationIgnored
    @Injected(\OnboardingContainer.connectWallet) private var connectWalletUseCase
    @ObservationIgnored
    @Injected(\OnboardingContainer.isWalletConnected) private var isWalletConnectedUseCase
    @ObservationIgnored
    @Injected(\OnboardingContainer.getAppState) private var getAppState
    
    enum WalletViewState: Equatable {
        case loading
        case initial
        case isConnecting
        case isConnected
        case hasContract
        case error(String)
    }
    
    var state: WalletViewState = .loading
    
    var showConnectWithMetamask = false
    
    func handleDismissError() {
        self.state = .initial
    }
    
    func handleError(error: Error) {
        print(error.localizedDescription)
        self.showConnectWithMetamask = false
        self.state = WalletViewState.error(error.localizedDescription)
    }
    
    func handleConnectWallet() async {
        do {
            self.state = .isConnecting
            let _ = try await self.connectWalletUseCase()
            await fetchAppState()
        } catch {
            self.handleError(error: error)
        }
    }

    func fetchAppState() async {
        do {
            let appState = try await self.getAppState()
            switch appState {
            case .isConnected:
                self.state = WalletViewState.isConnected
                break
            case .hasContract:
                self.state = WalletViewState.hasContract
                break
            default:
                self.state = WalletViewState.initial
                break
            }
        } catch {
            self.handleError(error: error)
        }
    }
}

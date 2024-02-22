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
        case isUnderwriting
        case isConnected
        case hasContract
        case error(String)
    }
    
    var state: WalletViewState = .loading
    
    func handleLogin() {
        self.state = .isConnecting
    }
    
    func handleUnderwriting() {
        self.state = .isUnderwriting
    }
    
    func handleConnectWallet() async {
        do {
            let _ = try await self.connectWalletUseCase()
            await fetchAppState()
        } catch {
            self.state = WalletViewState.error(error.localizedDescription)
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
            self.state = WalletViewState.error(error.localizedDescription)
        }
    }
}

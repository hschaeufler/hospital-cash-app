//
//  WalletViewModel.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 21.02.24.
//

import Foundation
import Factory

@Observable class WalletViewModel {
    @ObservationIgnored
    @Injected(\OnboardingContainer.connectWallet) private var connectWalletUseCase
    @ObservationIgnored
    @Injected(\OnboardingContainer.isWalletConnected) private var isWalletConnectedUseCase
    @ObservationIgnored
    @Injected(\OnboardingContainer.getAppState) private var getAppState
    @ObservationIgnored
    @Injected(\OnboardingContainer.disconnectWallet) private var disconnectWallet
    
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
    
    func showLogin() {
        self.state = .isConnecting
    }
    
    func showUnderwriting() {
        self.state = .isUnderwriting
    }
    
    func handleLogout() {
        self.disconnectWallet()
        self.state = .initial
    }
    
    func handleDismiss() {
        self.state = .initial
        Task {
            await fetchAppState()
        }
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

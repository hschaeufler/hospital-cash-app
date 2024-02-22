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
    @Injected(\OnboardingContainer.hasContract) private var hasContractUseCase
    
    var error: Error? = nil
    
    var isConnected: Bool {
        self.isWalletConnectedUseCase()
    }
    var hasContract = false;
    var isReady = false
    
    func handleConnectWallet() async {
        do {
            let _ = try await self.connectWalletUseCase()
            self.hasContract = try await self.hasContractUseCase()
        } catch {
            self.error = error
        }
    }
    
    func hasContract() async {
        do {
            self.hasContract = try await self.hasContractUseCase()
        } catch {
            self.error = error
        }
        self.isReady = true;
    }
    
    
}

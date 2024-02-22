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
    
    var error: Error? = nil
    
    var isConnected: Bool {
        self.isWalletConnectedUseCase()
    }
    var hasContract = false;
    
    func handleConnectWallet() async {
        do {
            let address = try await self.connectWalletUseCase()
        } catch {
            self.error = error
        }
    }
    
    
}

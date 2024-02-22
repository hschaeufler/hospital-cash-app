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
    
    var isConnected = true
    
    
}

//
//  OnboardingContainer.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 21.02.24.
//

import Foundation
import Factory


public final class OnboardingContainer: SharedContainer {
    public static let shared = OnboardingContainer()
    public let manager = ContainerManager()
}


extension OnboardingContainer {
    // config
    var walletConfig: Factory<Configuration.Wallet> {
        self { Configuration.Wallet() }
            .singleton
    }
    
    // datasources
    var walletLocalDataSource: Factory<WalletLocalDataSource> {
        self { WalletLocalDataSourceImpl(walletConfig: self.walletConfig() )}
    }
    
    // repositories
    var walletRepository: Factory<WalletRepository> {
        self { WalletRepositoryImpl(
            walletLocalDatasource: self.walletLocalDataSource()
        ) }
    }
    
    // usecases
    var connectWallet: Factory<ConnectWallet> {
        self { ConnectWalletUseCase(
            walletRepository: self.walletRepository()
        ) }
    }
    
    var isWalletConnected: Factory<IsWalletConnected> {
        self { IsWalletConnectedUsecase(
            walletRepository: self.walletRepository()
        ) }
    }
}

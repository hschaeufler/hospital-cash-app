//
//  HealthContainer.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import Foundation
import Factory

public final class HealthContainer: SharedContainer {
    public static let shared = HealthContainer()
    public let manager = ContainerManager()
}

extension HealthContainer {
    // Config
    var contractConfig: Factory<Configuration.Contract> {
        self { Configuration.Contract() }
            .singleton
    }
    
    // Datasources
    var hkLocalDatasource: Factory<HKLocalDatasource> {
        self { HKLocalDataSourceImpl(
            client: CoreContainer.shared.ethereumHttpClient(),
            contractConfig: self.contractConfig()
        )}
    }
    
    // Repositories
    var contractRepository: Factory<ContractRepository> {
        self {
            ContractRepositoryImpl(
                contractRemoteDatasource: self.contractRemoteDatasource(),
                walletLocalDatasource: OnboardingContainer.shared.walletLocalDataSource()
            )
        }
    }
    
    // Usecases
    var getContrat: Factory<GetContract> {
        self { GetContractUseCase(
            contractRepository: self.contractRepository()
        ) }
    }
    
    var getValidContrat: Factory<GetValidContract> {
        self { GetValidContractUseCase(
            contractRepository: self.contractRepository()
        ) }
    }
    
}

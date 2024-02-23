//
//  ContractContainer.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import Foundation
import Factory

public final class ContractContainer: SharedContainer {
    public static let shared = ContractContainer()
    public let manager = ContainerManager()
}

extension ContractContainer {
    // Config
    var contractConfig: Factory<Configuration.Contract> {
        self { Configuration.Contract() }
            .singleton
    }
    
    // Datasources
    var contractRemoteDatasource: Factory<ContractRemoteDatasource> {
        self { ContractRemoteDatasourceImpl(
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

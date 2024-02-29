//
//  CoreContainer.swift
//  HospitalCash
//
//  Created by hschaeufler on 31.01.24.
//

import Foundation
import Factory
import web3

public final class CoreContainer: SharedContainer {
     public static let shared = CoreContainer()
     public let manager = ContainerManager()
}


extension CoreContainer {
    // config
    var clientConfig: Factory<Configuration.Client> {
        self { Configuration.Client() }
            .singleton
    }
    
    // clients
    var restClient: Factory<RESTClient> {
        self { RESTClient() }
    }
    
    var ethereumHttpClient: Factory<EthereumHttpClient> {
        self {
            EthereumHttpClient(
                url: self.clientConfig().nodeRpcEndpoint,
                network: EthereumNetwork.fromString(self.clientConfig().chainId)
            )
        }
    }
    
    // datasources
    var ethereumRemoteDatasource: Factory<EthereumRemoteDatasource> {
        self { EthereumRemoteDatasourceImpl(
            client: self.ethereumHttpClient()
        ) }
    }
    
    // repsoitories
    var ethereumRepository: Factory<EthereumRepository> {
        self { EthereumRepositoryImpl(
            remoteDatasource: self.ethereumRemoteDatasource()
        ) }
    }
    
    // usecases
    var getTransactionState: Factory<GetTransactionState> {
        self { GetTransactionStateUseCase(
            ethereumRepository: self.ethereumRepository()
        ) }
    }
}

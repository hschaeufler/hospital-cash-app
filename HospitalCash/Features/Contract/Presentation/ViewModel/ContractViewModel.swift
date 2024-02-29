//
//  ContractViewModel.swift
//  HospitalCash
//
//  Created by hschaeufler on 23.02.24.
//

import Foundation
import Factory

@Observable class ContractViewModel {
    @ObservationIgnored
    @Injected(\ContractContainer.getContrat) private var getContract
    
    enum ContractViewState {
        case loading
        case loaded(ContractEntity)
        case error(String)
    }
    
    var state: ContractViewState = .loading
    

    func fetchContract() async {
        do {
            let contract = try await self.getContract()
            if let contract = contract {
                self.state = .loaded(contract)
            } else {
                self.state = .error("Es konnte keine Verträge geladnen werden.")
            }
        } catch {
            self.state = ContractViewState.error(error.localizedDescription)
        }
    }
}

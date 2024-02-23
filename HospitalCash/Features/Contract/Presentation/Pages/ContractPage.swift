//
//  ContractPage.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 23.02.24.
//

import SwiftUI

struct ContractPage: View {
    @State private var contractVM = ContractViewModel()
    
    var body: some View {
        Group {
            ContractViewState(viewState: contractVM.state)
                .onAppear {
                    Task {
                        await contractVM.fetchContract()
                    }
                }
        }
        .navigationTitle("Vertragsdetails")
    }
}

#Preview {
    NavigationStack {
        ContractPage()
    }
}

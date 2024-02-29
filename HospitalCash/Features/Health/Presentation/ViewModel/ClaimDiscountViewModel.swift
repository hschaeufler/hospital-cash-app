//
//  ClaimDiscountViewModel.swift
//  HospitalCash
//
//  Created by hschaeufler on 24.02.24.
//

import Foundation

import SwiftUI
import Factory

@Observable class ClaimDiscountViewModel {
    @ObservationIgnored
    @Injected(\HealthContainer.claimDiscount) private var claimDiscount
    
    enum ViewState {
        case loading
        case loaded
        case accessDenied
        case error(String)
    }
    
    var state: ViewState = .loaded
    
    func handleClaimDiscount() async {
        do {
            self.state = .loading
            let _ = try await self.claimDiscount()
            self.state = .loaded
        } catch CommonError.accessDenied {
            self.state = .accessDenied
        }  catch {
            self.state = ViewState.error(error.localizedDescription)
        }
    }

}

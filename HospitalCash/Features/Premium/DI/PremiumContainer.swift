//
//  PremiumCalculationContainer.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 31.01.24.

import Foundation
import Factory

// See:https://hmlongco.github.io/Factory/documentation/factory/containers
public final class PremiumContainer: SharedContainer {
     public static let shared = PremiumContainer()
     public let manager = ContainerManager()
}


extension PremiumContainer {
    var calculateBMI: Factory<CalculateBMI> {
        self { CalculateBMIUseCase() }
    }
    
    var checkHealthQuestionValidity: Factory<CheckHealthQuestionValidity> {
        self { CheckHealthQuestionValidityUseCase() }
    }
}

//
//  CoreContainer.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 31.01.24.
//

import Foundation
import Factory

public final class CoreContainer: SharedContainer {
     public static let shared = CoreContainer()
     public let manager = ContainerManager()
}


extension CoreContainer {
    var calculateBMI: Factory<CalculateBMI> {
        self { CalculateBMIUseCase() }
    }
    
    var checkHealthQuestionValidity: Factory<CheckHealthQuestionValidity> {
        self { CheckHealthQuestionValidityUseCase() }
    }
}

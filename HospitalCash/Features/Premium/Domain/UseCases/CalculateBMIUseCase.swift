//
//  CalculateBMIUseCase.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 31.01.24.
//

import Foundation

class CalculateBMIUseCase {
    
    func callAsFunction(height: Int, weight: Int) -> Double {
        let heightInMeters = Double(height) / 100
        let bmi = (Double(weight) / (heightInMeters * heightInMeters))
        return (bmi * 100).rounded() / 100
    }
}

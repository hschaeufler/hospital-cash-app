//
//  TestView.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 02.02.24.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        Text(test)
            .task {
                func main() async throws {
                    let result = try await MetamaskDatasourceImpl().callSmartContract()
                    print(result)
                }
            }
    }
}

#Preview {
    TestView()
}

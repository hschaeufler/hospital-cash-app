//
//  CopyButton.swift
//  HospitalCash
//
//  Created by Holger Schäufler on 20.02.24.
//

import SwiftUI

struct CopyButton: View {
    var copyString: String

    var body: some View {
        Button {
            UIPasteboard.general.string = copyString
        } label: {
            Image(systemName: "doc.on.doc")
        }
    }
}

#Preview {
    VStack {
        CopyButton(copyString: "Test")
            .buttonStyle(.plain)
            .foregroundStyle(.secondary)
        CopyButton(copyString: "Test")
    }

}

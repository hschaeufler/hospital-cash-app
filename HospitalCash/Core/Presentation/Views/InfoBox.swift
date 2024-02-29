//
//  InfoBox.swift
//  HospitalCash
//
//  Created by hschaeufler on 28.01.24.
//

import SwiftUI

struct InfoBox: View {
    var titleKey: LocalizedStringKey
    var contentKey: LocalizedStringKey
    var systemImage: String?
    
    init(_ titleKey: LocalizedStringKey,
         contentKey: LocalizedStringKey,
         systemImage: String? = nil
    ) {
        self.titleKey = titleKey
        self.contentKey = contentKey
        self.systemImage = systemImage
    }
    
    var body: some View {
        GroupBox {
            VStack (alignment: .leading) {
                Label(titleKey, systemImage: systemImage ?? "info.bubble")
                    .bold()
                Text(contentKey)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

#Preview {
    InfoBox("Gesundheitsfragen", contentKey: "GESUNDHEITSFRAGEN_INFO")
}

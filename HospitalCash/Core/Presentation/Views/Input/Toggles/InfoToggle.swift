//
//  InfoToggle.swift
//  HospitalCash
//
//  Created by hschaeufler on 28.01.24.
//

import SwiftUI

struct InfoToggle: View {
    var titleKey: LocalizedStringKey
    var contentKey: LocalizedStringKey
    var systemImage: String
    @Binding var isOn: Bool
    
    init(_ titleKey: LocalizedStringKey,
         contentKey: LocalizedStringKey,
         systemImage: String,
         isOn: Binding<Bool>
    ) {
        self.titleKey = titleKey
        self.contentKey = contentKey
        self.systemImage = systemImage
        self._isOn = isOn
    }
    

    var body: some View {
        VStack(alignment: .leading) {
            Toggle(
                    titleKey,
                    systemImage: systemImage,
                    isOn: $isOn
            )
            .bold()
            Text(contentKey)
                .foregroundStyle(.secondary)
                .padding(1)
        }
    }
}

#Preview {
    InfoToggle(
        "Stationäre Behandlung",
        contentKey: "GESUNDHEITSFRAGE_PSYCHOTHERAPIE",
        systemImage: "cross.case",
        isOn: .constant(true)
    )
}

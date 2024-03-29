//
//  OutputDateRangeField.swift
//  HospitalCash
//
//  Created by hschaeufler on 20.02.24.
//

import SwiftUI

struct OutputDateRangeField: View {
    var titleKey: LocalizedStringKey
    var caption: LocalizedStringKey?
    var startDate: Date
    var endDate: Date
    var allowCopy = false
    
    @ScaledMetric var verticalSpacing = 10
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: verticalSpacing
        ) {
            Text(titleKey)
                .bold()
            if let caption = caption {
                Text(caption)
                    .foregroundStyle(.secondary)
            }
            HStack {
                Text(startDate.formatted(date: .numeric, time: .omitted))
                Spacer()
                Text(" - ")
                Spacer()
                Text(endDate.formatted(date: .numeric, time: .omitted))
                if allowCopy {
                    CopyButton(
                        copyString: "\(startDate.formatted(date: .numeric, time: .omitted)) - \(endDate.formatted(date: .numeric, time: .omitted))"
                    )
                    .foregroundStyle(.secondary)
                    .padding(.leading, 10)
                }
            }
        }
    }
}

#Preview {
    OutputDateRangeField(
        titleKey: "Test",
        caption: "Das ist eine Description",
        startDate: Date(),
        endDate: Date(),
        allowCopy: true
    )
}

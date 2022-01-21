//
//  LabelledDivider.swift
//  Establish
//
//  Created by Joshua Brown on 17/01/2022.
//

import Foundation
import SwiftUI

struct LabelledDivider: View {

    private let label: String
    private let lineColor: Color

    init(label: String, lineColor: Color = .gray) {
        self.label = label
        self.lineColor = lineColor
    }

    var body: some View {
        HStack {
            line
            Text(label)
                .foregroundColor(lineColor)
            line
        }
    }

    var line: some View {
        VStack {
            Divider()
                .background(lineColor)
        }
    }
}

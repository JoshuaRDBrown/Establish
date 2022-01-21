//
//  CheckboxView.swift
//  Establish
//
//  Created by Joshua Brown on 17/01/2022.
//

import SwiftUI

public enum CheckBoxShape: String {
    case circle
    case square

    var filled: String {
        switch self {
        case .circle: return "checkmark.circle.fill"
        case .square: return "checkmark.square.fill"
        }
    }

    var empty: String {
        switch self {
        case .circle: return "circle"
        case .square: return "square"
        }
    }
}

public struct CheckBoxView: View {
    public let checkedColor: Color
    public let shape: CheckBoxShape
    public let width: CGFloat
    public let height: CGFloat

    private let themeManager: ThemeManager

    private let isChecked: Bool

    public init(checkedColor: Color, isChecked: Bool, shape: CheckBoxShape, width: CGFloat, height: CGFloat, themeManager: ThemeManager) {
        self.checkedColor = checkedColor
        self.isChecked = isChecked
        self.shape = shape
        self.width = width
        self.height = height
        self.themeManager = themeManager
    }

    public var body: some View {
        Image(systemName: isChecked ? shape.filled : shape.empty)
            .resizable()
            .frame(width: width, height: height, alignment: .center)
            .foregroundColor(isChecked ? checkedColor : .gray)
    }
}

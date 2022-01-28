//
//  ThemeManager.swift
//  Establish
//
//  Created by Joshua Brown on 08/11/2021.
//

import Foundation
import SwiftUI

public class ThemeManager {

    public static let shared: ThemeManager = ThemeManager()

    public init() { }

    public var isDarkMode: Bool {
        UIScreen.main.traitCollection.userInterfaceStyle == .dark
    }

    public func color(for tag: ThemeManagerColor) -> Color {
        switch tag {
        case .textPrimary:
            return Color(UIColor(named: "textPrimary")!)
        case .textSecondary:
            return Color(UIColor(named: "textSecondary")!)
        case .brandGreen:
            return Color(UIColor(named: "brandGreen")!)
        case .primaryButton:
            return Color(UIColor(named: "primaryButton")!)
        case .primaryButtonDisabled:
            return Color(UIColor(named: "primaryButtonDisabled")!)
        case .primaryBackground:
            return Color(UIColor(named: "primaryBackground")!)
        case .greyBackground:
            return .gray
        case .checkbox:
            return Color(UIColor(named: "checkbox")!)
        case .textDisabled:
            return Color(UIColor(named: "textDisabled")!)
        }
    }
}

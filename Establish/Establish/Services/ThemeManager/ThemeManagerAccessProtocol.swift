//
//  ThemeManagerAccessProtocol.swift
//  Establish
//
//  Created by Joshua Brown on 08/11/2021.
//

import Foundation

public protocol ThemeManagerAccessProtocol {
    var themeManager: ThemeManager { get }
}

public extension ThemeManagerAccessProtocol {
    var themeManager: ThemeManager {
        ThemeManager.shared
    }
}

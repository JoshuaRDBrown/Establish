//
//  AppContext.swift
//  Establish
//
//  Created by Joshua Brown on 27/10/2021.
//

import Foundation
import FirebaseAuth

public final class AppContext {

    public static let shared: AppContext = AppContext()

    public init() { }

    public var userObject: User? {
        Auth.auth().currentUser
    }

    public var isFirstLaunch: Bool {
        if UserDefaultsUtils.shared.isKeyAlreadySet(key: "appHasBeenLaunchedOnce") {
            return false
        }

        UserDefaultsUtils.shared.setValue(for: "appHasBeenLaunchedOnce", value: true)
        return true
    }
    
    public var themeManager: ThemeManager {
        ThemeManager.shared
    }
}

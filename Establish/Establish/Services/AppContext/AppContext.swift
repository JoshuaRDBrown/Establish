//
//  AppContext.swift
//  Establish
//
//  Created by Joshua Brown on 27/10/2021.
//

import Foundation
import Firebase

public final class AppContext {

    public static let shared: AppContext = AppContext()

    public init() { }

    public var userObject: User? {
        Auth.auth().currentUser
    }

    public var isFirstLaunch: Bool {

        let defaults = UserDefaults.standard

        if (defaults.string(forKey: "appHasBeenLaunchedOnce") != nil) {
            return false
        }

        defaults.set(true, forKey: "appHasBeenLaunchedOnce")
        return true
    }
}

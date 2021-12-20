//
//  AppFlowCoordinator.swift
//  Establish
//
//  Created by Joshua Brown on 27/10/2021.
//

import Foundation
import SwiftUI

public final class AppFlowCoordinator {

    private var window: UIWindow

    public init(window: UIWindow) {
        self.window = window
    }

    func showLogin() {
        let vc = LoginCoordinator().instantiate()
        window.rootViewController = vc
    }
    
    func showWelcome() {
        let vc = WelcomeCoordinator().instantiate()
        window.rootViewController = vc
    }
}

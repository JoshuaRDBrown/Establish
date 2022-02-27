//
//  AppFlow.swift
//  Establish
//
//  Created by Joshua Brown on 27/10/2021.
//

import Foundation
import SwiftUI

public protocol AppFlowAccessProtocol {
    var appFlow: AppFlow { get }
}

public final class AppFlow: AppContextAccessProtocol {

    let coordinator: AppFlowCoordinator

    var window: UIWindow

    init(window: UIWindow) {
        self.window = window
        self.coordinator = AppFlowCoordinator(window: window)
    }

    func start() {
        if appContext.isFirstLaunch {
            coordinator.showCreateAccount()
        } else if appContext.userObject != nil {
            coordinator.showHomePage()
        } else {
            coordinator.showLogin()
        }
    }
}

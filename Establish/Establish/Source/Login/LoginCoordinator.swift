//
//  LoginCoordinator.swift
//  Establish
//
//  Created by Joshua Brown on 28/10/2021.
//

import Foundation
import SwiftUI

class LoginCoordinator: Coordinator {

    weak var rootHostingController: UIHostingController<LoginView>?

    init() { }

    public func instantiate() -> UIViewController {
        let view = LoginView()
        let hostingController = UIHostingController(rootView: view)
        rootHostingController = hostingController
        return hostingController
    }
}

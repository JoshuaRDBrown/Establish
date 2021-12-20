//
//  WelcomeCoordinator.swift
//  Establish
//
//  Created by Joshua Brown on 16/12/2021.
//

import Foundation
import SwiftUI 

final class WelcomeCoordinator: Coordinator {
    
    weak var rootHostingController: UIHostingController<WelcomeView>?

    init() { }

    func instantiate() -> UIViewController {
        let view = WelcomeView(viewModel: WelcomeViewModel())
        let hostingController = UIHostingController(rootView: view)
        rootHostingController = hostingController
        return hostingController
    }
}

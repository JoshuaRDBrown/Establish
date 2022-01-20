//
//  LoginCoordinator.swift
//  Establish
//
//  Created by Joshua Brown on 28/10/2021.
//

import Foundation
import SwiftUI

class LoginCoordinator: EnqueuingCoordinator {
    typealias EnqueueContextType = LoginViewModel.RouteType
    
    weak var rootHostingController: UIHostingController<LoginView>?

    init() { }

    func instantiate() -> UIViewController {
        let viewModel = LoginViewModel(coordinator: .init(self))
        let view = LoginView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: view)
        hostingController.modalPresentationStyle = .fullScreen
        rootHostingController = hostingController
        return hostingController
    }
    
    func enqueue(with context: LoginViewModel.RouteType, animated: Bool) {
        switch context {
        case .home:
            let vc = HomeCoordinator().instantiate()
            rootHostingController?.present(vc, animated: true, completion: nil)
        case .createAccount:
            let vc = CreateAccountCoordinator().instantiate()
            rootHostingController?.present(vc, animated: true, completion: nil)
        }
    }
}

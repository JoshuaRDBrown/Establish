//
//  CreateAccountCoordinator.swift
//  Establish
//
//  Created by Joshua Brown on 20/01/2022.
//

import Foundation
import SwiftUI

final class CreateAccountCoordinator: EnqueuingCoordinator, AppContextAccessProtocol {
    typealias EnqueueContextType = CreateAccountViewModel.RouteType
    
    weak var rootHostingController: UIHostingController<CreateAccountView>?

    init() { }

    func instantiate() -> UIViewController {
        let view = CreateAccountView(viewModel: CreateAccountViewModel(coordinator: .init(self)))
        let hostingController = UIHostingController(rootView: view)
        hostingController.modalPresentationStyle = .fullScreen
        rootHostingController = hostingController
        return hostingController
    }
    
    func enqueue(with context: CreateAccountViewModel.RouteType, animated: Bool) {
        switch context {
        case .login:
            //Ensures user does not dismiss to no view if they did not load create account from the login screen
            if appContext.isFirstLaunch {
                let vc = LoginCoordinator().instantiate()
                rootHostingController?.present(vc, animated: true, completion: nil)
            } else {
                rootHostingController?.dismiss(animated: true, completion: nil)
            }
        case .inviteFriends:
            let vc = InviteFriendsCoordinator().instantiate()
            rootHostingController?.present(vc, animated: true, completion: nil)
        }
    }
}

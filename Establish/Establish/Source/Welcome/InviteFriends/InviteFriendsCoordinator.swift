//
//  InviteFriendsCoordinator.swift
//  Establish
//
//  Created by Joshua Brown on 20/01/2022.
//

import Foundation
import SwiftUI

class InviteFriendsCoordinator: EnqueuingCoordinator {
    typealias EnqueueContextType = InviteFriendsViewModel.RouteType
    
    weak var rootHostingController: UIHostingController<InviteFriendsView>?

    init() { }

    func instantiate() -> UIViewController {
        let view = InviteFriendsView(viewModel: InviteFriendsViewModel(coordinator: .init(self)))
        let hostingController = UIHostingController(rootView: view)
        hostingController.modalPresentationStyle = .fullScreen
        rootHostingController = hostingController
        return hostingController
    }
    
    func enqueue(with context: InviteFriendsViewModel.RouteType, animated: Bool) {
        switch context {
        case .home:
            let vc = HomeCoordinator().instantiate()
            rootHostingController?.present(vc, animated: true, completion: nil)
        }
    }
}

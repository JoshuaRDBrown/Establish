//
//  InviteFriendsViewModel.swift
//  Establish
//
//  Created by Joshua Brown on 20/01/2022.
//

import Foundation

class InviteFriendsViewModel {

    enum RouteType {
        case home
    }
    
    private let coordinator: EnqueueViewCoordinator<InviteFriendsViewModel.RouteType>
    
    init(coordinator: EnqueueViewCoordinator<InviteFriendsViewModel.RouteType>) {
        self.coordinator = coordinator
    }
    
    func navigateToHomeScreen() {
        coordinator.enqueue(with: .home, animated: true)
    }
}

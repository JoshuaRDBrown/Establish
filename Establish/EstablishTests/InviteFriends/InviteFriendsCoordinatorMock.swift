//
//  InviteFriendsCoordinatorMock.swift
//  EstablishTests
//
//  Created by Joshua Brown on 20/01/2022.
//

import Foundation
import SwiftUI
@testable import Establish

class InviteFriendsCoordinatorMock: EnqueuingCoordinator {
    typealias EnqueueContextType = InviteFriendsViewModel.RouteType
    weak var rootHostingController: UIHostingController<InviteFriendsView>?
    
    var context: EnqueueContextType?
    
    func enqueue(with context: InviteFriendsViewModel.RouteType, animated: Bool) {
        self.context = context
    }
}

//
//  InviteFriendsViewModelTests.swift
//  EstablishTests
//
//  Created by Joshua Brown on 20/01/2022.
//

import Foundation
import XCTest
@testable import Establish

final class InviteFriendsViewModelTests: XCTestCase {
    
    private let coordinator = InviteFriendsCoordinatorMock()
    
    func testNavigateToHomeScreen() {
        let viewModel = InviteFriendsViewModel(coordinator: EnqueueViewCoordinator<InviteFriendsViewModel.RouteType>(coordinator))
        XCTAssertNil(coordinator.context)
        viewModel.navigateToHomeScreen()
        XCTAssertEqual(coordinator.context, InviteFriendsViewModel.RouteType.home)
    }
}

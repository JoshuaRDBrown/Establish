//
//  LoginCoordinatorMock.swift
//  EstablishTests
//
//  Created by Joshua Brown on 20/01/2022.
//

import Foundation
import SwiftUI
@testable import Establish

class LoginCoordinatorMock: EnqueuingCoordinator {
    typealias EnqueueContextType = LoginViewModel.RouteType
    weak var rootHostingController: UIHostingController<LoginView>?
    
    var context: EnqueueContextType?
    
    func enqueue(with context: LoginViewModel.RouteType, animated: Bool) {
        self.context = context
    }
}

//
//  CreateAccountCoordinatorMock.swift
//  EstablishTests
//
//  Created by Joshua Brown on 20/01/2022.
//

import Foundation
import SwiftUI
@testable import Establish

class CreateAccountCoordinatorMock: EnqueuingCoordinator {
    typealias EnqueueContextType = CreateAccountViewModel.RouteType
    weak var rootHostingController: UIHostingController<CreateAccountView>?
    
    var context: EnqueueContextType?
    
    func enqueue(with context: CreateAccountViewModel.RouteType, animated: Bool) {
        self.context = context
    }
}

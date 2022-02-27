//
//  CreateNewEventCoordinator.swift
//  Establish
//
//  Created by Joshua Brown on 28/01/2022.
//

import Foundation
import SwiftUI

class CreateNewEventCoordinator: EnqueuingCoordinator, AppContextAccessProtocol {

    typealias EnqueueContextType = CreateNewEventViewModel.RouteType
    
    weak var rootHostingController: UIHostingController<CreateNewEventView>?

    init() { }

    func instantiate() -> UIViewController {
        let viewModel = CreateNewEventViewModel(coordinator: .init(self))
        let view = CreateNewEventView(viewModel: viewModel, themeManager: appContext.themeManager)
        let hostingController = UIHostingController(rootView: view)
        hostingController.modalPresentationStyle = .fullScreen
        rootHostingController = hostingController
        return hostingController
    }
    
    func enqueue(with context: CreateNewEventViewModel.RouteType, animated: Bool) {
        switch context {
        case .dismiss:
            rootHostingController?.dismiss(animated: animated, completion: nil)
        case .next(let payload):
            let vc = NewEventConfigurationCoordinator().instantiate(with: payload)
            rootHostingController?.present(vc, animated: true, completion: nil)
        }
    }
}

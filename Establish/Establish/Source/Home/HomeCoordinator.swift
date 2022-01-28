//
//  HomeCoordinator.swift
//  Establish
//
//  Created by Joshua Brown on 20/01/2022.
//

import Foundation
import SwiftUI

class HomeCoordinator: EnqueuingCoordinator {
    typealias EnqueueContextType = HomeViewModel.RouteType
    
    weak var rootHostingController: UIHostingController<HomeView>?

    init() { }

    func instantiate() -> UIViewController {
        let viewModel = HomeViewModel(coordinator: .init(self))
        let view = HomeView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: view)
        hostingController.modalPresentationStyle = .fullScreen
        rootHostingController = hostingController
        return hostingController
    }
    
    func enqueue(with context: HomeViewModel.RouteType, animated: Bool) {
        switch context {
        case .createEvent:
            let vc = CreateEventCoordinator().instantiate()
            rootHostingController?.present(vc, animated: true, completion: nil)
        }
    }
}

//
//  CreateEventCoordinator.swift
//  Establish
//
//  Created by Joshua Brown on 28/01/2022.
//

import Foundation
import SwiftUI

class CreateEventCoordinator: EnqueuingCoordinator {

    typealias EnqueueContextType = CreateEventViewModel.RouteType
    
    weak var rootHostingController: UIHostingController<CreateEventView>?

    init() { }

    func instantiate() -> UIViewController {
        let viewModel = CreateEventViewModel(coordinator: .init(self))
        let view = CreateEventView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: view)
        hostingController.modalPresentationStyle = .fullScreen
        rootHostingController = hostingController
        return hostingController
    }
    
    func enqueue(with context: CreateEventViewModel.RouteType, animated: Bool) {
        switch context {
        case .monzoBlogWebView(let url):
            let vc = UIHostingController(rootView: WebView(request: URLRequest(url: URL(string: url)!)))
            rootHostingController?.present(vc, animated: true, completion: nil)
        }
    }
}

//
//  NewEventConfigurationCoordinator.swift
//  Establish
//
//  Created by Joshua Brown on 27/02/2022.
//

import Foundation
import SwiftUI

class NewEventConfigurationCoordinator: EnqueuingCoordinator, AppContextAccessProtocol {

    typealias EnqueueContextType = NewEventConfigurationViewModel.RouteType
    
    weak var rootHostingController: UIHostingController<NewEventConfigurationView>?

    init() { }

    func instantiate(with eventDetails: CreateNewEventViewModel.EventDetails) -> UIViewController {
        let viewModel = NewEventConfigurationViewModel(coordinator: .init(self), eventDetails: eventDetails)
        let view = NewEventConfigurationView(viewModel: viewModel, themeManager: appContext.themeManager)
        let hostingController = UIHostingController(rootView: view)
        hostingController.modalPresentationStyle = .fullScreen
        rootHostingController = hostingController
        return hostingController
    }
    
    func enqueue(with context: NewEventConfigurationViewModel.RouteType, animated: Bool) {
        switch context {
        case .dismiss:
            rootHostingController?.dismiss(animated: animated, completion: nil)
        case .monzoBlogWebView(let url):
            guard let url = URL(string: url) else { return }
            let request = URLRequest(url: url)
            let webView = UIHostingController(rootView: WebView(request: request))
            rootHostingController?.present(webView, animated: animated, completion: nil)
        }
    }
}

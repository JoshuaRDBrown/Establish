//
//  CreateEventViewModel.swift
//  Establish
//
//  Created by Joshua Brown on 28/01/2022.
//

import Foundation

class CreateEventViewModel: ObservableObject {
    
    @Published var eventName = ""
    @Published var eventLocation = ""
    @Published var eventDate = Date()
    @Published var toggledMonzoLink = false
    @Published var currentlyInputtedTag = ""
    @Published var storedTags: [String] = []
    @Published var monzoPaymentLink = ""
    
    enum RouteType {
        case monzoBlogWebView(url: String)
    }
    
    private let coordinator: EnqueueViewCoordinator<CreateEventViewModel.RouteType>
    
    init(coordinator: EnqueueViewCoordinator<CreateEventViewModel.RouteType>) {
        self.coordinator = coordinator
    }
    
    func openMonzoBlog() {
        coordinator.enqueue(with: .monzoBlogWebView(url: "https://monzo.com/blog/2019/02/04/pay-anyone-link"), animated: true)
    }
    
    
}

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
    @Published var toggledRecurringEvent = false
    @Published var currentlyInputtedTag = ""
    @Published var storedTags: [String] = []
    @Published var monzoPaymentLink = ""
    @Published var currentScreen: Screen = .initialDetails
    
    enum RouteType {
        case monzoBlogWebView(url: String)
        case dismiss
    }
    
    enum Screen {
        case initialDetails
        case additionalDetails
    }
    
    private let coordinator: EnqueueViewCoordinator<CreateEventViewModel.RouteType>
    
    init(coordinator: EnqueueViewCoordinator<CreateEventViewModel.RouteType>) {
        self.coordinator = coordinator
    }
    
    func openMonzoBlog() {
        coordinator.enqueue(with: .monzoBlogWebView(url: "https://monzo.com/blog/2019/02/04/pay-anyone-link"), animated: true)
    }
    
    func dismissView() {
        coordinator.enqueue(with: .dismiss, animated: true)
    }
    
    var shouldCreateButtonBeDisabled: Bool {
        eventName.isEmpty || eventLocation.isEmpty
    }
    
    func addNewTag() {
        storedTags.append(currentlyInputtedTag)
        currentlyInputtedTag = ""
    }
    
    func removeTag(name: String) {
        self.storedTags = storedTags.filter { $0 != name }
    }
    
    var eventDayOfMonth: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = eventDate.dateFormatWithSuffix()
        return dateFormatter.string(from: eventDate)
    }
    
    var eventDayOfWeek: String {
        eventDate.dayOfWeek()
    }
}

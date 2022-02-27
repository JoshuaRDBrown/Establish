//
//  NewEventConfigurationViewModel.swift
//  Establish
//
//  Created by Joshua Brown on 27/02/2022.
//

import Foundation
import Combine

class NewEventConfigurationViewModel: ObservableObject, AppContextAccessProtocol {
    
    @Published public var toggledMonzoLink = false
    @Published public var toggledRecurringEvent = false
    @Published public var recurringEventSelection: RecurringDateSelection = .everyday
    @Published public var currentlyInputtedTag = ""
    @Published public private(set) var storedTags: [String] = []
    @Published public var monzoPaymentLink = ""
    
    public let monzoAlertTitle = "Paying with Monzo"
    public let monzoAlertMessage = "If your event requires a deposit to book, this option allows you to enter your Monzo payment link. This link will be shown in the event details as a required action for all participants."
    
    enum RecurringDateSelection: String {
        case everyday
        case everyWeek
        case everyMonth
        case yearly
        case custom
    }
    
    enum RouteType {
        case monzoBlogWebView(url: String)
        case dismiss
    }
    
    private let coordinator: EnqueueViewCoordinator<NewEventConfigurationViewModel.RouteType>
    private let firestoreHandler: UpdateFirestoreHandler
    private var subscriptions = Set<AnyCancellable>()
    
    public let eventDetails: CreateNewEventViewModel.EventDetails
    
    init(coordinator: EnqueueViewCoordinator<NewEventConfigurationViewModel.RouteType>,
         eventDetails: CreateNewEventViewModel.EventDetails, firestoreHander: UpdateFirestoreHandler = UpdateFirestoreHandler.shared) {
        self.coordinator = coordinator
        self.eventDetails = eventDetails
        self.firestoreHandler = firestoreHander
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
        dateFormatter.dateFormat = eventDetails.date.dateFormatWithSuffix()
        return dateFormatter.string(from: eventDetails.date)
    }
    
    var eventDayOfWeek: String {
        eventDetails.date.dayOfWeek()
    }
    
    var eventFullDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM y @ HH:mm"
        return dateFormatter.string(from: eventDetails.date)
    }
    
    func openMonzoBlog() {
        coordinator.enqueue(with: .monzoBlogWebView(url: "https://monzo.com/blog/2019/02/04/pay-anyone-link"), animated: true)
    }
    
    func dismiss() {
        coordinator.enqueue(with: .dismiss, animated: true)
    }
    
    func didTapBack() {
        self.dismiss()
    }
    
    private func createEventAccessCode() -> String {
        GenericHelpers.shared.generateRandomString(length: 6)
    }
    
    func createEvent() {
        let payload = EventPayload(accessCode: createEventAccessCode(),
                                   name: eventDetails.name,
                                   location: eventDetails.location,
                                   date: eventDetails.date.timeIntervalSince1970,
                                   isRecurring: toggledRecurringEvent,
                                   recurringType: toggledRecurringEvent ? recurringEventSelection.rawValue : nil,
                                   monzoLink: monzoPaymentLink.isEmpty ? nil : monzoPaymentLink,
                                   creator: appContext.userObject?.displayName ?? "",
                                   tags: storedTags,
                                   attendees: [])
        
        firestoreHandler.createNewEvent(payload: payload)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print(error)
                }
            }, receiveValue: { [weak self] _ in
                self?.coordinator.enqueue(with: .dismiss, animated: true)
            })
            .store(in: &subscriptions)
    }
}

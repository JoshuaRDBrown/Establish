//
//  CreateNewEventViewModel.swift
//  Establish
//
//  Created by Joshua Brown on 27/02/2022.
//

import Foundation
import Combine

class CreateNewEventViewModel: ObservableObject {
    
    @Published public var eventName = ""
    @Published public var eventLocation = ""
    @Published public var eventDate = Date()
    @Published public var isLoadingMapData = false
    @Published public private(set) var locationServiceResults: [LocationSearchMapItem] = []
    @Published public var hasPickedASuggestedLocation = false
    
    enum RouteType {
        case dismiss
        case next(payload: EventDetails)
    }
    
    struct EventDetails {
        let name: String
        let location: String
        let date: Date
    }
    
    private var subscriptions = Set<AnyCancellable>()
    private var cancellable: AnyCancellable?
    
    private let locationService: LocationSearchService
    
    public let coordinator: EnqueueViewCoordinator<RouteType>
    
    init(coordinator: EnqueueViewCoordinator<RouteType>, locationService: LocationSearchService = LocationSearchService.shared) {
        self.coordinator = coordinator
        self.locationService = locationService
        
        $eventLocation
            .receive(on: RunLoop.main)
            .debounce(for: .seconds(2), scheduler: RunLoop.main)
            .sink { [weak self] location in
                guard !location.isEmpty else {
                    self?.hasPickedASuggestedLocation = false
                    self?.locationServiceResults = []
                    return
                }
                guard let self = self, !self.hasPickedASuggestedLocation else { return }
                self.search(location: location)
            }
            .store(in: &subscriptions)
        
        self.cancellable = locationService.locationSearchPublisher.sink { [weak self] locations in
            self?.hasPickedASuggestedLocation = false
            self?.locationServiceResults = locations.compactMap({ LocationSearchMapItem(mapItem: $0) })
            self?.isLoadingMapData = false
        }
    }
    
    private func search(location: String) {
        self.isLoadingMapData = true
        locationService.search(location: location)
    }
    
    public var shouldCreateButtonBeDisabled: Bool {
        eventName.isEmpty || eventLocation.isEmpty
    }
    
    public func dismiss() {
        coordinator.enqueue(with: .dismiss, animated: true)
    }
    
    public func didTapNext() {
        let eventDetails = EventDetails(name: eventName, location: eventLocation, date: eventDate)
        
        coordinator.enqueue(with: .next(payload: eventDetails), animated: true)
    }
}

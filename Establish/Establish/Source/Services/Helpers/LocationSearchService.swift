//
//  LocationSearchService.swift
//  Establish
//
//  Created by Joshua Brown on 05/02/2022.
//

import Foundation
import Combine
import MapKit

struct LocationSearchMapItem: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var subtitle: String
    
    init(mapItem: MKMapItem) {
        self.title = mapItem.name ?? ""
        self.subtitle = mapItem.placemark.title ?? ""
    }
}

public final class LocationSearchService {
    public let locationSearchPublisher = PassthroughSubject<[MKMapItem], Never>()
    public static let shared = LocationSearchService()
    
    public func search(location: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = location
        
        MKLocalSearch(request: request).start { [weak self] response, error in
            guard let response = response else { return }
            self?.locationSearchPublisher.send(response.mapItems)
        }
    }
}

//
//  HomeViewModel.swift
//  Establish
//
//  Created by Joshua Brown on 20/01/2022.
//

import Foundation

class HomeViewModel {
    
    enum RouteType { }
    
    private let coordinator: EnqueueViewCoordinator<HomeViewModel.RouteType>
    
    init(coordinator: EnqueueViewCoordinator<HomeViewModel.RouteType>) {
        self.coordinator = coordinator
    }
}

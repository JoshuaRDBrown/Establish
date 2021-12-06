//
//  AppContextAccessProtocol.swift
//  AppServices
//
//  Created by Joshua Brown on 11/11/2021.
//

import Foundation

public protocol AppContextAccessProtocol {
    var appContext: AppContext { get }
}

public extension AppContextAccessProtocol {
    var appContext: AppContext {
        AppContext.shared
    }
}

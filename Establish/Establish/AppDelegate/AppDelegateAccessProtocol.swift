//
//  AppDelegateAccessProtocol.swift
//  Establish
//
//  Created by Joshua Brown on 27/10/2021.
//

import Foundation
import UIKit

public protocol AppDelegateAccessProtocol {
    var window: UIWindow { get }
    var appDelegate: AppDelegateProtocol { get }
}

public extension AppDelegateAccessProtocol {
    var window: UIWindow {
        return appDelegate.primaryWindow
    }
}

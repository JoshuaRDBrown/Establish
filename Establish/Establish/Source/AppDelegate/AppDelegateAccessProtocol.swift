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
    var rootViewController: UIViewController { get }
    var appDelegate: AppDelegateProtocol { get }
}

public extension AppDelegateAccessProtocol {
    
    var appDelegate: AppDelegateProtocol {
        return appDelegate
    }
    
    var window: UIWindow {
        return appDelegate.primaryWindow
    }
    
    var rootViewController: UIViewController {
        guard let screen =  UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}

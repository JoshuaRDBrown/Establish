//
//  AppDelegateProtocol.swift
//  Establish
//
//  Created by Joshua Brown on 27/10/2021.
//

import Foundation
import UIKit

public protocol AppDelegateProtocol: AnyObject {
    var primaryWindow: UIWindow { get }
}

//
//  Coordinator.swift
//  Establish
//
//  Created by Joshua Brown on 27/10/2021.
//

import Foundation
import SwiftUI

public protocol Coordinator: AnyObject {
    associatedtype CustomView: View

    var rootHostingController: UIHostingController<CustomView>? { get }
}

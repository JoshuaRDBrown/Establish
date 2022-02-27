//
//  EnqueuingCoordinator.swift
//  Establish
//
//  Created by Joshua Brown on 27/10/2021.
//

import Foundation
import SwiftUI

public protocol EnqueuingCoordinator: Coordinator {
    associatedtype EnqueueContextType

    func enqueue(with context: EnqueueContextType, animated: Bool)
}

public class EnqueueViewCoordinator<EnqueueContextType>: EnqueuingCoordinator {

    public typealias CustomView = AnyView

    public weak var rootHostingController: UIHostingController<CustomView>?

    private let _enqueue: (EnqueueContextType, Bool) -> ()

    public init<Base: EnqueuingCoordinator>(_ base: Base) where EnqueueContextType == Base.EnqueueContextType {
        _enqueue = base.enqueue
    }

    public func enqueue(with context: EnqueueContextType, animated: Bool) {
        _enqueue(context, animated)
    }
}

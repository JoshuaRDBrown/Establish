//
//  XCTestCase+GWT.swift
//  EstablishTests
//
//  Created by Joshua Brown on 20/12/2021.
//

import Foundation
import XCTest

extension XCTestCase {
    @discardableResult
    public func given<T>(_ text: String, block: () throws -> T) rethrows -> T {
        return try XCTContext.runActivity(named: "GIVEN \(text)") { _ in return try block() }
    }
    
    @discardableResult
    public func when<T>(_ text: String, block: () throws -> T) rethrows -> T {
        return try XCTContext.runActivity(named: "WHEN \(text)") { _ in return try block() }
    }
    
    @discardableResult
    public func then<T>(_ text: String, block: () throws -> T) rethrows -> T {
        return try XCTContext.runActivity(named: "THEN \(text)") { _ in return try block() }
    }
}

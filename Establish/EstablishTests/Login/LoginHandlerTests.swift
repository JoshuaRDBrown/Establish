//
//  LoginHandlerTests.swift
//  EstablishTests
//
//  Created by Joshua Brown on 20/01/2022.
//

import Foundation
import Combine

import XCTest
@testable import Establish

final class LoginHandlerTests: XCTestCase {
    
    private var subscriptions = Set<AnyCancellable>()
        
    func testSHA256() {
        let loginHandler = LoginHandler()
        
        let result = loginHandler.sha256("Hello world")
        XCTAssertEqual(result, "64ec88ca00b268e5ba1a35678a1b5316d212f4f366b2477232534a8aeca37f3c")
    }
    
    func testLogin() {
        var userID: String?
        
        let loginHandler = given("A LoginHandler") {
            LoginHandler()
        }
        
        when("A correct username and password are entered") {
            let expectation = expectation(description: "User should be logged in")
            loginHandler.login(email: "joshua.brown@test.com", password: "Welcome1")
                .sink(receiveCompletion: { _ in
                    
                }, receiveValue: { authResult in
                    userID = authResult.user.uid
                    expectation.fulfill()
                })
                .store(in: &subscriptions)
        }
        
        then("The user object should provide us with the logged in users details") {
            waitForExpectations(timeout: 5, handler: nil)
            XCTAssertEqual(userID, "GnjxdieulNS1HYdSHOOTkf3xePu1")
        }
    }
}

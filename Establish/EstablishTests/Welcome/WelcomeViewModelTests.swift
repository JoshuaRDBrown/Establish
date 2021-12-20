//
//  WelcomeViewModelTests.Swift
//  EstablishTests
//
//  Created by Joshua Brown on 20/12/2021.
//

import Foundation
import Combine

import XCTest
@testable import Establish

final class WelcomeViewModelTests: XCTestCase {
    
    private var subscriptions = Set<AnyCancellable>()
    
    func testHasEmptyFields() {
        let viewModel = WelcomeViewModel()
        
        given("All the sign up form fields are filled in") {
            viewModel.username = "Joshua"
            viewModel.email = "test@test.com"
            viewModel.password = "Welcome1"
            viewModel.passwordRepeated = "Welcome1"
        }
        
        let result1 = when("hasEmptyFields() is called") {
            viewModel.hasEmptyFields()
        }
        
        then("I expect its return value to be false") {
            XCTAssertFalse(result1)
        }
        
        given("Some of the sign up form fields are not filled in") {
            viewModel.username = ""
            viewModel.email = ""
        }
        
        let result2 = when("hasEmptyFields() is called") {
            viewModel.hasEmptyFields()
        }
        
        then("I expect its return value to be true") {
            XCTAssertTrue(result2)
        }
    }
    
    func testIsEmailValid() {
        
        let viewModel = WelcomeViewModel()
        
        let formattedEmail = given("A well formatted email") {
            "joshua.brown@test.com"
        }
        
        let result1 = when("isEmailValid() is called with this email as its argument") {
            viewModel.isEmailValid(emailAddress: formattedEmail)
        }
        
        then("I expect its return value to be true") {
            XCTAssertTrue(result1)
        }
        
        let unformattedEmail = given("A badly formatted email") {
            "jfewijohguhehgq3uhe"
        }
        
        let result2 = when("isEmailValid() is called with this email as its argument") {
            viewModel.isEmailValid(emailAddress: unformattedEmail)
        }
        
        then("I expect its return value to be false") {
            XCTAssertFalse(result2)
        }
    }
    
    func testCalculatePasswordStrength() {
        let viewModel = WelcomeViewModel()
        
        let input1 = given("A password with no special chars and is less than 8 chars long") {
            "123"
        }
        
        let result1 = when("calculatePasswordStrength() is called with the password as its argument") {
            viewModel.calculatePasswordStrength(password: input1)
        }
        
        then("I expect the return value to equal .weak") {
            XCTAssertEqual(result1, .weak)
        }
        
        let input2 = given("A password with no special chars and is more than 8 chars long") {
            "wowASortOfSecurePassword"
        }
        
        let result2 = when("calculatePasswordStrength() is called with the password as its argument") {
            viewModel.calculatePasswordStrength(password: input2)
        }
        
        then("I expect the return value to equal .medium") {
            XCTAssertEqual(result2, .medium)
        }
        
        let input3 = given("A password with special chars and is more than 8 chars long") {
            "wowAVerySecurePassword!!!"
        }
        
        let result3 = when("calculatePasswordStrength() is called with the password as its argument") {
            viewModel.calculatePasswordStrength(password: input3)
        }
        
        then("I expect the return value to equal .strong") {
            XCTAssertEqual(result3, .strong)
        }
    }
    
    func testDoPasswordsMatch() {
        let viewModel = WelcomeViewModel()
        
        var password1 = ""
        var password2 = ""
        
        given("Two passwords which match") {
            password1 = "HelloWorld"
            password2 = "HelloWorld"
        }
        
        let result1 = when("doPasswordMatch() is called with those strings as its arguments") {
            viewModel.doPasswordsMatch(password: password1, repeatedPassword: password2)
        }
        
        then("I expect the return value to equal true") {
            XCTAssertTrue(result1)
        }
        
        given("Two passwords which do not match") {
            password1 = "HelloWorld"
            password2 = "HelloEarth"
        }
        
        let result2 = when("doPasswordMatch() is called with those strings as its arguments") {
            viewModel.doPasswordsMatch(password: password1, repeatedPassword: password2)
        }
        
        then("I expect the return value to equal false") {
            XCTAssertFalse(result2)
        }
    }
    
    func testIsEmailUnique() {
        let viewModel = WelcomeViewModel()
        let completion1 = self.expectation(description: "receiveValue should be called!")
        
        var isUnique = false
        
        let email = given("A unique email") {
            "test@test.com"
        }
        
        when("isEmailUnique() is called with an email as an arguement") {
            viewModel.isEmailUnique(emailAddress: email)
                .sink { _ in
                } receiveValue: { value in
                    isUnique = value
                    completion1.fulfill()
                }
                .store(in: &subscriptions)
        }
        
        then("I expect the return value to equal true") {
            waitForExpectations(timeout: 10)
            XCTAssertTrue(isUnique)
        }
        
        let completion2 = self.expectation(description: "receiveValue should be called!")
        
        let email2 = given("An email that is already in use") {
            "joshua.brown@test.com"
        }
        
        when("isEmailUnique() is called with an email as an arguement") {
            viewModel.isEmailUnique(emailAddress: email2)
                .sink { _ in
                } receiveValue: { value in
                    isUnique = value
                    completion2.fulfill()
                }
                .store(in: &subscriptions)
        }
        
        then("I expect the return value to equal false") {
            waitForExpectations(timeout: 10)
            XCTAssertFalse(isUnique)
        }
    }    
}

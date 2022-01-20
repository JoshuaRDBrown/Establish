//
//  LoginViewModelTests.swift
//  EstablishTests
//
//  Created by Joshua Brown on 20/01/2022.
//

import Foundation
import Combine
import SwiftKeychainWrapper

import XCTest
@testable import Establish

final class LoginViewModelTests: XCTestCase {
    
    private let coordinator = LoginCoordinatorMock()
    
    func testShouldRememberMeBeChecked() {
        
        let viewModel = LoginViewModel(coordinator: EnqueueViewCoordinator<LoginViewModel.RouteType>(coordinator))
        
        given("There are no user defaults set for the remember me key") {
            UserDefaultsUtils.shared.remove(key: "rememberMeChecked")
            XCTAssertFalse(UserDefaultsUtils.shared.isKeyAlreadySet(key: "rememberMeChecked"))
        }
        
        let result1 = when("shouldRememberMeBeChecked() is called") {
            viewModel.shouldRememberMeBeChecked
        }
        
        then("the returned value should be false and a User Defaults key should be created for it") {
            XCTAssertFalse(result1)
            XCTAssertTrue(UserDefaultsUtils.shared.isKeyAlreadySet(key: "rememberMeChecked"))
        }
        
        given("The User Defaults value for rememberMeChecked is false") {
            UserDefaultsUtils.shared.setValue(for: "rememberMeChecked", value: false)
        }
        
        let result2 = when("shouldRememberMeBeChecked() is called") {
            viewModel.shouldRememberMeBeChecked
        }
        
        then("the returned value should be false") {
            XCTAssertFalse(result2)
        }
        
        given("The User Defaults value for rememberMeChecked is true") {
            UserDefaultsUtils.shared.setValue(for: "rememberMeChecked", value: true)
        }
        
        let result3 = when("shouldRememberMeBeChecked() is called") {
            viewModel.shouldRememberMeBeChecked
        }
        
        then("the returned value should be true") {
            XCTAssertTrue(result3)
        }
    }
    
    func testRememberMeToggled() {
        let viewModel = LoginViewModel(coordinator: EnqueueViewCoordinator<LoginViewModel.RouteType>(coordinator))
        
        given("The hasCheckedRememberMe value is already false and the user has inputted their login details") {
            viewModel.hasCheckedRememberMe = false
            viewModel.emailAddress = "John.Doe@gmail.com"
            viewModel.password = "Welcome1"
        }
        
        when("rememberMeToggled() is called") {
            viewModel.rememberMeToggled()
        }
        
        then("The keychain has saved the users details and the value is true") {
            XCTAssertEqual(KeychainWrapper.standard.string(forKey: "savedEmailAddress"), "John.Doe@gmail.com")
            XCTAssertEqual(KeychainWrapper.standard.string(forKey: "savedPassword"), "Welcome1")
        }
        
        given("The hasCheckedRememberMe value is already true") {
            viewModel.hasCheckedRememberMe = true
        }
        
        when("rememberMeToggled() is called") {
            viewModel.rememberMeToggled()
        }
        
        then("The keychain should have deleted the saved details") {
            XCTAssertNotEqual(KeychainWrapper.standard.string(forKey: "savedEmailAddress"), "John.Doe@gmail.com")
            XCTAssertNotEqual(KeychainWrapper.standard.string(forKey: "savedPassword"), "Welcome1")
        }
    }
    
    func testShowCreateAccountScreen() {
        let viewModel = LoginViewModel(coordinator: EnqueueViewCoordinator<LoginViewModel.RouteType>(coordinator))
        
        XCTAssertNil(coordinator.context)
        
        viewModel.showCreateAccountScreen()
        
        XCTAssertEqual(coordinator.context, LoginViewModel.RouteType.createAccount)
    }
    
    func testUserDetailsAreFetchedOnInit() {
        given("The user has saved their credentials in the keychain") {
            KeychainWrapper.standard.set("John.Doe@gmail.com", forKey: "savedEmailAddress")
            KeychainWrapper.standard.set("Welcome1", forKey: "savedPassword")
            UserDefaultsUtils.shared.setValue(for: "rememberMeChecked", value: true)
        }
        
        let viewModel = when("LoginViewModel is init'd") {
            LoginViewModel(coordinator: EnqueueViewCoordinator<LoginViewModel.RouteType>(coordinator))
        }
        
        then("The keychain values are prepopulated into the email and password properties") {
            XCTAssertEqual(viewModel.emailAddress, "John.Doe@gmail.com")
            XCTAssertEqual(viewModel.password, "Welcome1")
        }
    }
    
    func testLogin() {
        let viewModel = given("A LoginViewModel") {
            LoginViewModel(coordinator: EnqueueViewCoordinator<LoginViewModel.RouteType>(coordinator))
        }
        
        when("A user has inputted correct login details and taps login") {
            viewModel.emailAddress = "joshua.brown@test.com"
            viewModel.password = "Welcome1"
            
            viewModel.login()
        }
        
        then("The coordinator should take the user to the home page") {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                XCTAssertEqual(self.coordinator.context, LoginViewModel.RouteType.home)
            }
        }
    }
}

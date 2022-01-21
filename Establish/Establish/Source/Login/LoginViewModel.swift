//
//  LoginViewModel.swift
//  Establish
//
//  Created by Joshua Brown on 17/01/2022.
//

import Foundation
import Combine
import SwiftKeychainWrapper
import AuthenticationServices
import FirebaseAuth

final class LoginViewModel: ObservableObject {
    
    @Published var hasCheckedRememberMe = false
    @Published var emailAddress = ""
    @Published var password = ""
    @Published var loginError = ""
    @Published var currentNonce = ""
    
    private let rememberMeKey = "rememberMeChecked"
    private let emailAddressKey = "savedEmailAddress"
    private let passwordKey = "savedPassword"
    
    private let coordinator: EnqueueViewCoordinator<LoginViewModel.RouteType>
    private let loginHandler: LoginHandler
    
    private var subscriptions = Set<AnyCancellable>()
    
    enum RouteType {
        case createAccount
        case home
    }
    
    init(coordinator: EnqueueViewCoordinator<LoginViewModel.RouteType>, loginHandler: LoginHandler = LoginHandler()) {
        self.coordinator = coordinator
        self.loginHandler = loginHandler
        self.hasCheckedRememberMe = shouldRememberMeBeChecked
        
        if shouldRememberMeBeChecked {
            self.emailAddress = KeychainWrapper.standard.string(forKey: self.emailAddressKey) ?? ""
            self.password = KeychainWrapper.standard.string(forKey: self.passwordKey) ?? ""
        }
    }
    
    func login() {
        loginHandler.login(email: self.emailAddress, password: self.password)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.loginError = error.localizedDescription
                }
            }, receiveValue: { [weak self] _ in
                self?.coordinator.enqueue(with: .home, animated: true)
            })
            .store(in: &subscriptions)
    }
    
    func loginWithApple(creds: AuthCredential) {
        loginHandler.login(credentials: creds)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.loginError = error.localizedDescription
                }
            }, receiveValue: { [weak self] _ in
                self?.coordinator.enqueue(with: .home, animated: true)
            })
            .store(in: &subscriptions)
    }
    
    func loginWithGoogle() {
        loginHandler.login()
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.loginError = error.localizedDescription
                }
            }, receiveValue: { [weak self] _ in
                self?.coordinator.enqueue(with: .home, animated: true)
            })
            .store(in: &subscriptions)
    }
    
    func showCreateAccountScreen() {
        coordinator.enqueue(with: .createAccount, animated: true)
    }
    
    var shouldRememberMeBeChecked: Bool {
        if UserDefaultsUtils.shared.isKeyAlreadySet(key: self.rememberMeKey) {
            return UserDefaultsUtils.shared.getValue(for: self.rememberMeKey)
        }
        UserDefaultsUtils.shared.setValue(for: self.rememberMeKey, value: false)
        return false
    }
    
    func rememberMeToggled() {
        self.hasCheckedRememberMe.toggle()
        UserDefaultsUtils.shared.setValue(for: self.rememberMeKey, value: hasCheckedRememberMe)
        
        if hasCheckedRememberMe {
            KeychainWrapper.standard.set(self.emailAddress, forKey: self.emailAddressKey)
            KeychainWrapper.standard.set(self.password, forKey: self.passwordKey)
        } else {
            KeychainWrapper.standard.removeObject(forKey: self.emailAddressKey)
            KeychainWrapper.standard.removeObject(forKey: self.passwordKey)
        }
    }
    
    func handleAppleSignInRequest(_ request: ASAuthorizationAppleIDRequest) {
        let nonce = loginHandler.generateNonce()
        self.currentNonce = nonce
        request.requestedScopes = [.fullName, .email]
        request.nonce = loginHandler.sha256(nonce)
    }
    
    //TODO: - Test this when I have Apple Developer Program subscription
    func handleAppleSignInCompletion(_ authResult: Result<ASAuthorization, Error>) {
        switch authResult {
        case .success(let authResult):
            switch authResult.credential {
            case let appleIDCreds as ASAuthorizationAppleIDCredential:
                guard currentNonce != "", let appleIDToken = appleIDCreds.identityToken, let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                    self.loginError = "An error occurred while trying to sign in with Apple, please try again later."
                    return
                }
                
                let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: currentNonce)
                self.loginWithApple(creds: credential)
            default: break
            }
        case .failure(let error):
            self.loginError = error.localizedDescription
        }
    }
}

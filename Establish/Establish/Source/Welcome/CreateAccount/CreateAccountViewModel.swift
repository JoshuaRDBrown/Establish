//
//  CreateAccountViewModel.swift
//  Establish
//
//  Created by Joshua Brown on 19/01/2022.
//

import Foundation
import Combine
import FirebaseAuth

enum PasswordStrength: String {
    case weak = "Weak"
    case medium = "Medium"
    case strong = "Strong"
}

class CreateAccountViewModel: ObservableObject {
    
    @Published public var username = ""
    @Published public var email = ""
    @Published public var password = ""
    @Published public var passwordRepeated = ""
    @Published public var isLoading = false
    
    @Published private(set) public var emailError = ""
    @Published private(set) public var passwordError = ""
    @Published private(set) public var passwordStrength: PasswordStrength = .weak
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let coordinator: EnqueueViewCoordinator<CreateAccountViewModel.RouteType>
    private let createAccountHandler: CreateAccountHandler
    
    enum RouteType {
        case login
        case inviteFriends
    }
    
    init(coordinator: EnqueueViewCoordinator<CreateAccountViewModel.RouteType>, createAccountHandler: CreateAccountHandler = CreateAccountHandler()) {
        self.coordinator = coordinator
        self.createAccountHandler = createAccountHandler
        
        $email
            .receive(on: DispatchQueue.main)
            .debounce(for: .seconds(2), scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] value in
                //Prevent making an unnecessary network call on init
                guard value != "" else { return }
                guard let self = self else { return }
                self.isEmailUnique(emailAddress: value)
                    .sink(receiveCompletion: { completion in
                        if case let .failure(error) = completion {
                            self.emailError = error.localizedDescription
                        }
                    }, receiveValue: { isUnique in
                        let isValid = self.isEmailValid(emailAddress: value)
                        
                        if !isUnique {
                            self.emailError = "The provided email address is already in use."
                        } else if !isValid {
                            self.emailError = "Please enter a valid email address."
                        } else {
                            self.emailError = ""
                        }
                    })
                    .store(in: &self.subscriptions)
            })
            .store(in: &subscriptions)
        
        $password
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.passwordStrength = self.calculatePasswordStrength(password: value)
            })
            .store(in: &subscriptions)
        
        $passwordRepeated
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                guard let self = self else { return }
                let passwordsMatch = self.doPasswordsMatch(password: self.password, repeatedPassword: value)
                
                if !passwordsMatch {
                    self.passwordError = "Passwords do not match."
                } else {
                    self.passwordError = ""
                }
            })
            .store(in: &subscriptions)
    }
    
    var shouldNextButtonBeTappable: Bool {
        self.emailError.isEmpty && self.passwordError.isEmpty && !hasEmptyFields()
    }
    
    func hasEmptyFields() -> Bool {
        return ![username, email, password, passwordRepeated].filter { $0.isEmpty }.isEmpty
    }
    
    func isEmailUnique(emailAddress: String) -> Future<Bool, Error> {
        return createAccountHandler.isUsernameUnique(email: emailAddress)
    }
    
    func isEmailValid(emailAddress: String) -> Bool {
        guard emailAddress != "" else { return true }
        
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: emailAddress)
    }
    
    func calculatePasswordStrength(password: String) -> PasswordStrength {
        let hasEightChars = password.count >= 8
        let hasSpecialChars = NSPredicate(format: "SELF MATCHES %@", argumentArray: ["^(?=.*[!@#$%&_]).*$"]).evaluate(with: password)
        
        if hasEightChars && hasSpecialChars {
            return .strong
        } else if hasEightChars {
            return .medium
        }
        return .weak
    }
    
    func doPasswordsMatch(password: String, repeatedPassword: String) -> Bool {
        guard password != "" && repeatedPassword != "" else { return true }
        return password == repeatedPassword
    }
    
    func nextButtonTapped() {
        self.isLoading = true
        createAccountHandler.createAccount(email: self.email, password: self.password, username: self.username)
            .receive(on: DispatchQueue.main)
            .debounce(for: .seconds(2), scheduler: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure:
                    self?.emailError = "An error occurred while creating your account, please try again later."
                case .finished:
                    self?.coordinator.enqueue(with: .inviteFriends, animated: true)
                }
            }, receiveValue: {  _ in })
            .store(in: &subscriptions)
    }
    
    func alreadyHaveAccountButtonTapped() {
        coordinator.enqueue(with: .login, animated: true)
    }
}

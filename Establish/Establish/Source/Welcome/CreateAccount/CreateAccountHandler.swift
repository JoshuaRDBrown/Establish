//
//  CreateAccountHandler.swift
//  Establish
//
//  Created by Joshua Brown on 19/12/2021.
//

import Foundation
import Combine
import FirebaseAuth

final class CreateAccountHandler {
    
    private var subscriptions = Set<AnyCancellable>()
    
    enum CreateAccountError: Error {
        case unwrappingDataFailed
    }
    
    init() { }
    
    func isUsernameUnique(email: String) -> Future<Bool, Error> {
        return Future { promise in
            Auth.auth().fetchSignInMethods(forEmail: email, completion: { (signInMethods, error) in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                promise(.success(signInMethods?.isEmpty ?? true))
            })
        }
    }
    
    func createAccount(email: String, password: String, username: String) -> Future<AuthDataResult, Error> {
        return Future { promise in
            Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] (authResult, error) in
                guard let self = self else { return }
                
                if let error = error {
                    promise(.failure(error))
                    return
                }
                
                if let result = authResult {
                    self.setDisplayName(to: username)
                        .sink(receiveCompletion: { completion in
                            if case let .failure(error) = completion {
                                promise(.failure(error))
                            }
                        }, receiveValue: { _ in
                            promise(.success(result))
                        })
                        .store(in: &self.subscriptions)
                } else {
                    promise(.failure(CreateAccountError.unwrappingDataFailed))
                }
            })
        }
    }
    
    private func setDisplayName(to username: String) -> Future<Void, Error> {
        return Future { promise in
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = username
            changeRequest?.commitChanges { error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }
    }
}

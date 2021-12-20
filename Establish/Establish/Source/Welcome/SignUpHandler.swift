//
//  SignUpHandler.swift
//  Establish
//
//  Created by Joshua Brown on 19/12/2021.
//

import Foundation
import Combine
import FirebaseAuth

final class SignUpHandler {
    
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
}

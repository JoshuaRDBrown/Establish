//
//  LoginHandler.swift
//  Establish
//
//  Created by Joshua Brown on 19/01/2022.
//

import Foundation
import Combine
import FirebaseAuth
import CryptoKit

final class LoginHandler {
    
    func login(email: String, password: String) -> Future<AuthDataResult, Error> {
        return Future { promise in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let result = authResult {
                    promise(.success(result))
                    return
                } else {
                    promise(.failure(error!))
                    return
                }
            }
        }
    }
    
    func login(credentials: AuthCredential) -> Future<AuthDataResult, Error> {
        return Future { promise in
            Auth.auth().signIn(with: credentials) { authResult, error in
                if let result = authResult {
                    promise(.success(result))
                    return
                } else {
                    promise(.failure(error!))
                    return
                }
            }
        }
    }
    
    func generateNonce(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}

//
//  GenericHelpers.swift
//  Establish
//
//  Created by Joshua Brown on 27/02/2022.
//

import Foundation

public class GenericHelpers {
    
    public static let shared = GenericHelpers()
    
    init() { }
    
    public func generateRandomString(length: Int) -> String {
        let chars = "abcdefghijklmnopqrstuvwxyz0123456789"
        return String((0..<length).map{ _ in chars.randomElement()! })
    }
}

//
//  ModalView.swift
//  Establish
//
//  Created by Joshua Brown on 19/01/2022.
//

import Foundation
import SwiftUI

public struct ModalView: View {
    
    private let title: String
    private let description: String
    private let requiresUserInput: Bool
    
    @State private var userInput = ""
    
    public init(title: String, description: String, requiresUserInput: Bool = false) {
        self.title = title
        self.description = description
        self.requiresUserInput = requiresUserInput
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.4)
            VStack(spacing: .zero) {
                Text(title)
                Text(description)
                
            }
            .background(Color.white)
        }
        .zIndex(1)
    }
    
}

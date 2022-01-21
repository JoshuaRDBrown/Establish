//
//  ButtonStyle.swift
//  Establish
//
//  Created by Joshua Brown on 21/01/2022.
//

import Foundation
import SwiftUI

public enum ButtonStyle {
    
    public struct Primary: SwiftUI.ButtonStyle {
        let themeManager: ThemeManager
        let isDisabled: Bool
        
        public init(themeManager: ThemeManager, isDisabled: Bool = false) {
            self.themeManager = themeManager
            self.isDisabled = isDisabled
        }
        
        public func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .frame(maxWidth: .infinity, minHeight: 30)
                .font(.headline)
                .background(isDisabled ? .gray : themeManager.color(for: .primaryButton))
                .cornerRadius(8)
                .foregroundColor(isDisabled ? themeManager.color(for: .textDisabled) : .white)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.white, lineWidth: 1)
                )
        }
    }
    
    public struct Link: SwiftUI.ButtonStyle {
            let themeManager: ThemeManager
            
            public init(themeManager: ThemeManager) {
                self.themeManager = themeManager
            }
            
            public func makeBody(configuration: Self.Configuration) -> some View {
                configuration.label
                    .foregroundColor(.blue)
            }
        }
}

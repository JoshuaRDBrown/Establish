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
        let isActionButton: Bool
        
        public init(themeManager: ThemeManager, isDisabled: Bool = false, isActionButton: Bool = false) {
            self.themeManager = themeManager
            self.isDisabled = isDisabled
            self.isActionButton = isActionButton
        }
        
        private var buttonColor: Color {
            
            if self.isDisabled { return .gray }
            
            if isActionButton {
                return .orange
            }
            
            return themeManager.color(for: .primaryButton)
        }
        
        public func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .frame(maxWidth: .infinity, minHeight: 30)
                .font(.headline)
                .background(buttonColor)
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

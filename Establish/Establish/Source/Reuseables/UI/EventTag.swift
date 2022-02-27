//
//  EventTag.swift
//  Establish
//
//  Created by Joshua Brown on 04/02/2022.
//

import SwiftUI

struct EventTagView: View {
    
    private let tagName: String
    private let sizes: Sizes
    
    init(tagName: String, sizes: Sizes = Sizes()) {
        self.tagName = tagName
        self.sizes = sizes
    }
    
    var body: some View {
        HStack(spacing: .zero) {
            Text(tagName)
        }
        .padding(5)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(tagBorderColor(), lineWidth: 2))
        .frame(height: sizes.tagHeight)
    }
    
    private func tagBorderColor() -> Color {
        let colors: [Color] = [.blue, .red, .green, .orange]
        
        return colors.randomElement()!
    }
    
    struct Sizes {
        let tagWidth: CGFloat
        let tagHeight: CGFloat
        
        init(tagWidth: CGFloat = 10, tagHeight: CGFloat = 6) {
            self.tagWidth = tagWidth
            self.tagHeight = tagHeight
        }
    }
}

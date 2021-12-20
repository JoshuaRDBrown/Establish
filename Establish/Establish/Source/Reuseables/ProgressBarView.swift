//
//  ProgressBarView.swift
//  Establish
//
//  Created by Joshua Brown on 16/12/2021.
//

import SwiftUI

struct ProgressBarView: View {
    @Binding private var value: Float
    @Binding private var barColor: Color
    
    private let sizes: Sizes
    
    init(value: Binding<Float>, barColor: Binding<Color>, sizes: Sizes = Sizes()) {
        self._value = value
        self._barColor = barColor
        self.sizes = sizes
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(sizes.rectangleOpacity)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(barColor)
                    .animation(.linear)
            }.cornerRadius(sizes.rectangleCornerRadius)
        }
    }
    
    struct Sizes {
        let rectangleOpacity: Double
        let rectangleCornerRadius: CGFloat
        
        init(rectangleOpacity: Double = 0.3, rectangleCornerRadius: CGFloat = 45.0) {
            self.rectangleOpacity = rectangleOpacity
            self.rectangleCornerRadius = rectangleCornerRadius
        }
    }
}

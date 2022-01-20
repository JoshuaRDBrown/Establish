//
//  PasswordStrengthView.swift
//  Establish
//
//  Created by Joshua Brown on 16/12/2021.
//

import SwiftUI

struct PasswordStrengthView: View {
    
    private let themeManager: ThemeManager
    private let passwordStrength: String
    private let sizes: Sizes
    
    @Binding private var progressBarColor: Color
    @Binding private var progressBarValue: Float
    
    init(themeManager: ThemeManager,
         passwordStrength: String,
         progressBarColor: Binding<Color>,
         progressBarValue: Binding<Float>,
         sizes: Sizes = Sizes()) {
        self.themeManager = themeManager
        self.passwordStrength = passwordStrength
        self._progressBarColor = progressBarColor
        self._progressBarValue = progressBarValue
        self.sizes = sizes
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            ProgressBarView(value: $progressBarValue, barColor: $progressBarColor)
                .frame(height: sizes.progressBarViewHeight)
                .padding(.bottom, sizes.progressBarPaddingBottom)
            HStack(spacing: .zero) {
                Text("Password strength: ")
                Text(passwordStrength)
                    .bold()
                    .foregroundColor(progressBarColor)
            }
            .padding(.bottom, sizes.passwordStrengthLabelPaddingBottom)
            Text("Your password should be a combination of numbers and letters, be longer than 8 characters and contain some special characters (e.g: %$£@)")
                .foregroundColor(themeManager.color(for: .textSecondary))
                .font(.system(size: sizes.passwordStrengthInfoTextFontSize))
        }
    }
    
    struct Sizes {
        let progressBarViewHeight: CGFloat
        let progressBarPaddingBottom: CGFloat
        let passwordStrengthLabelPaddingBottom: CGFloat
        let passwordStrengthInfoTextFontSize: CGFloat
        
        init(progressBarViewHeight: CGFloat = 10,
             progressBarPaddingBottom: CGFloat = 5,
             passwordStrengthLabelPaddingBottom: CGFloat = 2,
             passwordStrengthInfoTextFontSize: CGFloat = 12) {
            self.progressBarViewHeight = progressBarViewHeight
            self.progressBarPaddingBottom = progressBarPaddingBottom
            self.passwordStrengthLabelPaddingBottom = passwordStrengthLabelPaddingBottom
            self.passwordStrengthInfoTextFontSize = passwordStrengthInfoTextFontSize
        }
    }
}

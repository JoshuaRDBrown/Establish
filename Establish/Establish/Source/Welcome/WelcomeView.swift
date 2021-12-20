//
//  WelcomeView.swift
//  Establish
//
//  Created by Joshua Brown on 16/12/2021.
//

import SwiftUI

struct WelcomeView: View, ThemeManagerAccessProtocol {
    
    @ObservedObject private var viewModel: WelcomeViewModel
    
    @State private var passwordStrength = "Weak"
    @State private var passwordProgressBarColor: Color = .red
    @State private var passwordStrengthProgressBarValue: Float = 0.0
    
    private let sizes: Sizes
    
    init(viewModel: WelcomeViewModel, sizes: Sizes = Sizes()) {
        self.viewModel = viewModel
        self.sizes = sizes
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text("Welcome 👋")
                .foregroundColor(themeManager.color(for: .brandGreen))
                .font(.system(size: sizes.welcomeTextFontSize))
                .padding(.bottom, sizes.smallPadding)
            Text("In order to use Establish, we require some details from you.")
                .foregroundColor(themeManager.color(for: .textSecondary))
                .font(.system(size: sizes.informativeTextFontSize))
            signupForm
                .padding(.top, sizes.largePadding)
        }
        .padding(sizes.largePadding)
        
        Spacer()
        
        formBottomButtons
    }
    
    @ViewBuilder
    private func textFieldBorderBottom(hasError: Bool) -> some View {
        Divider()
            .frame(height: sizes.inputDividerFrame)
            .padding(.horizontal, sizes.inputDividerPadding)
            .background(hasError ? .red : themeManager.color(for: .brandGreen))
    }
    
    private var formBottomButtons: some View {
        VStack(alignment: .center) {
            Button("Next", action: { })
                .padding(.horizontal, sizes.largePadding)
                .padding(.vertical, sizes.mediumPadding)
                .foregroundColor(.white)
                .background(themeManager.color(for: .brandGreen))
            Button("I already have an account", action: { })
                .foregroundColor(themeManager.color(for: .brandGreen))
        }
    }
    
    private var signupForm: some View {
        VStack(alignment: .leading, spacing: sizes.smallPadding) {
            TextField("Username", text: $viewModel.username)
            textFieldBorderBottom(hasError: false)
                .padding(.bottom, sizes.smallPadding)
            TextField("Email Address", text: $viewModel.email)
            textFieldBorderBottom(hasError: viewModel.emailError != "")
                .padding(.bottom, sizes.smallPadding)
            TextField("Password", text: $viewModel.password)
            textFieldBorderBottom(hasError: viewModel.passwordError != "")
                .padding(.bottom, sizes.smallPadding)
            if !viewModel.password.isEmpty {
                PasswordStrengthView(themeManager: self.themeManager, passwordStrength: passwordStrength, progressBarColor: $passwordProgressBarColor, progressBarValue: $passwordStrengthProgressBarValue)
                    .padding(.vertical, sizes.smallPadding)
                    .onChange(of: viewModel.passwordStrength, perform: { value in
                        setProgressBarValues(value: value)
                    })
            }
            
            TextField("Repeat Password", text: $viewModel.passwordRepeated)
            textFieldBorderBottom(hasError: viewModel.passwordError != "")
                .padding(.bottom, sizes.smallPadding)
            formError
        }
        .animation(Animation.default.speed(sizes.viewAnimationSpeed))
    }
        
    private var formError: some View {
        VStack(alignment: .leading, spacing: .zero) {
            if !viewModel.emailError.isEmpty {
                formErrorText(error: viewModel.emailError)
            }
            
            if !viewModel.passwordError.isEmpty {
                formErrorText(error: viewModel.passwordError)
            }
            Spacer()
        }
        .foregroundColor(.red)
    }
    
    @ViewBuilder
    private func formErrorText(error: String) -> some View {
        HStack {
            Image(systemName: "exclamationmark.triangle.fill")
            Text(error)
        }
        .padding(.bottom, sizes.smallPadding)
    }
    
    private func setProgressBarValues(value: PasswordStrength) {
        switch value {
        case .weak:
            self.passwordStrength = value.rawValue
            self.passwordProgressBarColor = .red
            self.passwordStrengthProgressBarValue = 0.3
        case .medium:
            self.passwordStrength = value.rawValue
            self.passwordProgressBarColor = .orange
            self.passwordStrengthProgressBarValue = 0.6
        case .strong:
            self.passwordStrength = value.rawValue
            self.passwordProgressBarColor = .green
            self.passwordStrengthProgressBarValue = 0.9
        }
    }
    
    struct Sizes {
        let smallPadding: CGFloat
        let mediumPadding: CGFloat
        let largePadding: CGFloat
        let welcomeTextFontSize: CGFloat
        let informativeTextFontSize: CGFloat
        let inputDividerFrame: CGFloat
        let inputDividerPadding: CGFloat
        let viewAnimationSpeed: Double
        
        init(smallPadding: CGFloat = 5,
             mediumPadding: CGFloat = 10,
             largePadding: CGFloat = 20,
             welcomeTextFontSize: CGFloat = 40,
             informativeTextFontSize: CGFloat = 17,
             inputDividerFrame: CGFloat = 2,
             inputDividerPadding: CGFloat = 30,
             viewAnimationSpeed: Double = 1) {
            self.smallPadding = smallPadding
            self.mediumPadding = mediumPadding
            self.largePadding = largePadding
            self.welcomeTextFontSize = welcomeTextFontSize
            self.informativeTextFontSize = informativeTextFontSize
            self.inputDividerFrame = inputDividerFrame
            self.inputDividerPadding = inputDividerPadding
            self.viewAnimationSpeed = viewAnimationSpeed
        }
        
    }
}

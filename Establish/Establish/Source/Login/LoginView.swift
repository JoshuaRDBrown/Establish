//
//  LoginView.swift
//  Establish
//
//  Created by Joshua Brown on 27/10/2021.
//

import Foundation
import SwiftUI
import AuthenticationServices

//TODO: - Style login screen
struct LoginView: View, ThemeManagerAccessProtocol {

    @ObservedObject private var viewModel: LoginViewModel
    @Environment(\.colorScheme) private var colorScheme
    @State private var showForgotPasswordModal = false
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            if showForgotPasswordModal {
                ModalView(title: "Forgot password",
                          description: "Please enter the email associated with the account and we will send you a password reset email.",
                          requiresUserInput: true)
            }
            VStack(spacing: .zero) {
                topBanner
                    .ignoresSafeArea()
                loginForm
            }
        }
        Spacer()
    }
    
    private var topBanner: some View {
        VStack(spacing: .zero) {
            Text("Establish")
                .foregroundColor(.white)
        }
        .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height / 3)
        .background(themeManager.color(for: .brandGreen))
    }
    
    private var loginForm: some View {
        VStack(alignment: .leading, spacing: .zero) {
            TextField("Email Address", text: $viewModel.emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack {
                CheckBoxView(checkedColor: themeManager.color(for: .checkbox), isChecked: viewModel.hasCheckedRememberMe, shape: .square, width: 20, height: 20, themeManager: self.themeManager)
                Text("Remember me")
                    .foregroundColor(themeManager.color(for: .textSecondary))
            }
            .onTapGesture { viewModel.rememberMeToggled() }
            .padding(.top, 10)
            
            Button("Login", action: viewModel.login)
            
            LabelledDivider(label: "or", lineColor: themeManager.color(for: .textSecondary))
            
            SignInWithAppleButton(.signIn, onRequest: viewModel.handleAppleSignInRequest, onCompletion: viewModel.handleAppleSignInCompletion)
                .frame(height: 35)
                .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
            
            Button("Create Account", action: viewModel.showCreateAccountScreen)
            Button("Forgot Password", action: { self.showForgotPasswordModal = true })

        }
        .padding(.horizontal, 20)
    }
}

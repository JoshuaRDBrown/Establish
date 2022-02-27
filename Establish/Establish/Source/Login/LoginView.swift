//
//  LoginView.swift
//  Establish
//
//  Created by Joshua Brown on 27/10/2021.
//

import Foundation
import SwiftUI
import AuthenticationServices
import GoogleSignIn

struct LoginView: View, ThemeManagerAccessProtocol {
    
    @ObservedObject private var viewModel: LoginViewModel
    @Environment(\.colorScheme) private var colorScheme
    @State private var showForgotPasswordModal = false
    
    private let sizes: Sizes
    
    init(viewModel: LoginViewModel, sizes: Sizes = Sizes()) {
        self.viewModel = viewModel
        self.sizes = sizes
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            Spacer()
            loginForm
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(themeManager.color(for: .brandGreen).edgesIgnoringSafeArea(.all))
    }
    
    private var loginForm: some View {
        VStack(spacing: .zero) {
            
            Text("Establish")
                .font(.largeTitle)
                .foregroundColor(themeManager.color(for: .brandGreen))
            Text("Organise social events, with ease")
                .font(.system(size: sizes.titleFontSize))
                .foregroundColor(themeManager.color(for: .textSecondary))
                .padding(.bottom, sizes.largePadding)
            
            TextField("Email Address", text: $viewModel.emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, sizes.mediumPadding)
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack(spacing: .zero) {
                CheckBoxView(checkedColor: themeManager.color(for: .checkbox), isChecked: viewModel.hasCheckedRememberMe, shape: .square, width: sizes.checkboxDimensions, height: sizes.checkboxDimensions, themeManager: self.themeManager)
                    .padding(.trailing, sizes.checkboxTrailingPadding)
                Text("Remember me")
                    .foregroundColor(themeManager.color(for: .textSecondary))
                Spacer()
            }
            .onTapGesture { viewModel.rememberMeToggled() }
            .padding(.top, sizes.smallPadding)
            Button("Login", action: viewModel.login)
                .buttonStyle(ButtonStyle.Primary(themeManager: self.themeManager,
                                                 isDisabled: viewModel.emailAddress.isEmpty || viewModel.password.isEmpty))
                .padding(.vertical, sizes.mediumPadding)
            LabelledDivider(label: "or", lineColor: themeManager.color(for: .textSecondary))
                .padding(.bottom, sizes.mediumPadding)
            thirdPartyLoginButtons
                .padding(.bottom, sizes.largePadding)
            linkButtons
        }
        .frame(maxWidth: UIScreen.main.bounds.width - sizes.loginFormDistanceFromEdge)
        .padding(sizes.largePadding)
        .background(Color.white)
        .cornerRadius(sizes.smallCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: sizes.smallCornerRadius)
                .stroke(.clear)
        )
        
    }
    
    private var thirdPartyLoginButtons: some View {
        VStack(spacing: .zero) {
            SignInWithAppleButton(.signIn, onRequest: viewModel.handleAppleSignInRequest, onCompletion: viewModel.handleAppleSignInCompletion)
                .frame(height: sizes.thirdPartyLoginButtonHeight)
                .padding(.bottom, sizes.mediumPadding)
                .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
            Button(action: { viewModel.loginWithGoogle() }) {
                HStack(spacing: .zero) {
                    Image("google-logo")
                        .resizable()
                        .frame(width: sizes.googleLogoDimensions, height: sizes.googleLogoDimensions)
                        .padding(.trailing, sizes.googleLogoPaddingTrailing)
                    Text("Sign in with Google")
                        .font(.system(size: sizes.googleSignInFontSize))
                }
            }
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .frame(height: sizes.thirdPartyLoginButtonHeight)
            .cornerRadius(sizes.largeCornerRadius)
            .background(
                RoundedRectangle(cornerRadius: sizes.largeCornerRadius)
                    .fill(Color.white)
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
            )
        }
    }
    
    private var linkButtons: some View {
        HStack(spacing: .zero) {
            Button(action: { }) {
                Text("Forgot password?")
                    .underline()
            }
            
            Spacer()
            
            Button(action: viewModel.showCreateAccountScreen) {
                Text("Create account")
                    .underline()
            }
        }
        .buttonStyle(ButtonStyle.Link(themeManager: self.themeManager))
    }
    
    struct Sizes {
        let smallPadding: CGFloat
        let mediumPadding: CGFloat
        let largePadding: CGFloat
        let checkboxDimensions: CGFloat
        let smallCornerRadius: CGFloat
        let largeCornerRadius: CGFloat
        let titleFontSize: CGFloat
        let checkboxTrailingPadding: CGFloat
        let loginFormDistanceFromEdge: CGFloat
        let googleLogoDimensions: CGFloat
        let thirdPartyLoginButtonHeight: CGFloat
        let googleSignInFontSize: CGFloat
        let googleLogoPaddingTrailing: CGFloat
        
        init(smallPadding: CGFloat = 10,
             mediumPadding: CGFloat = 12,
             largePadding: CGFloat = 20,
             checkboxDimensions: CGFloat = 20,
             smallCornerRadius: CGFloat = 4,
             largeCornerRadius: CGFloat = 8,
             titleFontSize: CGFloat = 20,
             checkboxTrailingPadding: CGFloat = 5,
             loginFormDistanceFromEdge: CGFloat = 100,
             googleLogoDimensions: CGFloat = 10,
             thirdPartyLoginButtonHeight: CGFloat = 35,
             googleSignInFontSize: CGFloat = 14,
             googleLogoPaddingTrailing: CGFloat = 4) {
            self.smallPadding = smallPadding
            self.mediumPadding = mediumPadding
            self.largePadding = largePadding
            self.checkboxDimensions = checkboxDimensions
            self.smallCornerRadius = smallCornerRadius
            self.largeCornerRadius = largeCornerRadius
            self.titleFontSize = titleFontSize
            self.checkboxTrailingPadding = checkboxTrailingPadding
            self.loginFormDistanceFromEdge = loginFormDistanceFromEdge
            self.googleLogoDimensions = googleLogoDimensions
            self.thirdPartyLoginButtonHeight = thirdPartyLoginButtonHeight
            self.googleSignInFontSize = googleSignInFontSize
            self.googleLogoPaddingTrailing = googleLogoPaddingTrailing
        }
    }
}

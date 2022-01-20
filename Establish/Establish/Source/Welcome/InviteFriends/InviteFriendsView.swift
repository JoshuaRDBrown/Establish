//
//  InviteFriendsView.swift
//  Establish
//
//  Created by Joshua Brown on 19/01/2022.
//

import Foundation
import MessageUI
import SwiftUI

struct InviteFriendsView: View, ThemeManagerAccessProtocol {
    
    private let viewModel: InviteFriendsViewModel
    private let sizes: Sizes
    
    init(viewModel: InviteFriendsViewModel, sizes: Sizes = Sizes()) {
        self.viewModel = viewModel
        self.sizes = sizes
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text("Invite friends 💬")
                .foregroundColor(themeManager.color(for: .brandGreen))
                .font(.system(size: sizes.inviteFriendsTitleFontSize))
                .padding(.bottom, sizes.inviteFriendsPaddingBottom)
            Text("Once you add your friends, you can then add them and be added to social event groups.")
                .foregroundColor(themeManager.color(for: .textSecondary))
                .font(.system(size: sizes.inviteFriendsDescFontSize))
            
            VStack(spacing: .zero) {
                Text("Invite using: ")
                    .padding(.bottom, sizes.smallPadding)
                    .font(.system(size: sizes.mediumPadding))
                    .foregroundColor(themeManager.color(for: .textSecondary))
                HStack(spacing: .zero) {
                    //TODO: - Add destination links when I have access to Apple Developer Program
                    contactButtons(label: "SMS", destination: "sms:123456&body=Join us")
                    Spacer()
                    contactButtons(label: "WhatsApp", destination: "")
                    Spacer()
                    contactButtons(label: "Email", destination: "")
                }
                Button("Invite friends later", action: viewModel.navigateToHomeScreen)
                    .padding(.top, sizes.mediumPadding)
                    .foregroundColor(themeManager.color(for: .brandGreen))
            }
            .padding(.top, sizes.largePadding)

            Spacer()
        }
        .padding(sizes.mediumPadding)
    }
    
    @ViewBuilder
    private func contactButtons(label: String, destination: String) -> some View {
        Button(label, action: {
            guard let url = URL(string: destination.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
                return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        })
        .padding(sizes.mediumPadding)
        .frame(height: sizes.contactButtonsHeight)
        .foregroundColor(Color.white)
        .background(themeManager.color(for: .brandGreen))
    }
    
    struct Sizes {
        
        let smallPadding: CGFloat
        let mediumPadding: CGFloat
        let largePadding: CGFloat
        let inviteFriendsTitleFontSize: CGFloat
        let inviteFriendsDescFontSize: CGFloat
        let inviteFriendsPaddingBottom: CGFloat
        let contactButtonsHeight: CGFloat
        
        init(smallPadding: CGFloat = 10,
             mediumPadding: CGFloat = 20,
             largePadding: CGFloat = 40,
             inviteFriendsTitleFontSize: CGFloat = 40,
             inviteFriendsDescFontSize: CGFloat = 17,
             inviteFriendsPaddingBottom: CGFloat = 5,
             contactButtonsHeight: CGFloat = 30) {
            self.smallPadding = smallPadding
            self.mediumPadding = mediumPadding
            self.largePadding = largePadding
            self.inviteFriendsTitleFontSize = inviteFriendsTitleFontSize
            self.inviteFriendsDescFontSize = inviteFriendsDescFontSize
            self.inviteFriendsPaddingBottom = inviteFriendsPaddingBottom
            self.contactButtonsHeight = contactButtonsHeight
        }
    }
}

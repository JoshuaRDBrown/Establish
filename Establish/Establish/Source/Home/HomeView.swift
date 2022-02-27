//
//  HomeView.swift
//  Establish
//
//  Created by Joshua Brown on 20/01/2022.
//

import Foundation
import SwiftUI

struct HomeView: View, AppContextAccessProtocol, ThemeManagerAccessProtocol {
    
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        topbar
        Divider()
            .frame(height: 3)
            .background(themeManager.color(for: .brandGreen))
        VStack(spacing: 10) {
//            Spacer()
//            EventListItem(eventTitle: "Bowling", eventDate: "12/08/2022 @ 7PM", eventImageURL: "", mostRecentActionString: "Jim created a poll", amountAttending: 5, themeManager: self.themeManager)
//                .padding(.horizontal, 15)
//
//            EventListItem(eventTitle: "Bowling", eventDate: "12/08/2022 @ 7PM", eventImageURL: "", mostRecentActionString: "Jim created a poll", amountAttending: 5, themeManager: self.themeManager)
//                .padding(.horizontal, 15)
//
//            EventListItem(eventTitle: "Bowling", eventDate: "12/08/2022 @ 7PM", eventImageURL: "", mostRecentActionString: "Jim created a poll", amountAttending: 5, themeManager: self.themeManager)
//                .padding(.horizontal, 15)
//
//            EventListItem(eventTitle: "Bowling", eventDate: "12/08/2022 @ 7PM", eventImageURL: "", mostRecentActionString: "Jim created a poll", amountAttending: 5, themeManager: self.themeManager)
//                .padding(.horizontal, 15)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(themeManager.color(for: .primaryBackground))
    }
    
    private var topbar: some View {
        HStack {
            Text("Establish")
                .foregroundColor(themeManager.color(for: .brandGreen))
                .font(.system(size: 26))
            Spacer()
            
            Button(action: {
                viewModel.createEventTapped()
            }, label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 26, height: 26)
                    .foregroundColor(themeManager.color(for: .brandGreen))
            })
            
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 26, height: 26)
        }
        .padding(.horizontal, 20)
    }
    
}

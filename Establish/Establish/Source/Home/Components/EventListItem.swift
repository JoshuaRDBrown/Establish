//
//  EventListItem.swift
//  Establish
//
//  Created by Joshua Brown on 26/01/2022.
//

import Foundation
import SwiftUI

struct EventListItem: View {
    
    private let eventTitle: String
    private let eventDate: String
    private let eventImageURL: String
    private let mostRecentActionString: String
    private let amountAttending: Int
    private let themeManager: ThemeManager
    //private let eventTags: [EventTags]
    
    init(eventTitle: String, eventDate: String, eventImageURL: String, mostRecentActionString: String, amountAttending: Int, themeManager: ThemeManager) {
        self.eventTitle = eventTitle
        self.eventDate = eventDate
        self.eventImageURL = eventImageURL
        self.mostRecentActionString = mostRecentActionString
        self.amountAttending = amountAttending
        self.themeManager = themeManager
    }
    
    var body: some View {
        HStack(spacing: .zero) {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 60, height: 60)
                .padding(.trailing, 12)
            
            VStack(alignment: .leading) {
                Text(eventTitle + "🎳")
                    .bold()
                    .font(.system(size: 22))
                Text("London, United Kingdom")
                    .foregroundColor(themeManager.color(for: .textSecondary))
                
                eventInfoSection(imageName: "calendar.badge.clock", info: eventDate)
                eventInfoSection(imageName: "person.fill", info: "Josh Brown + 5 others")
            }
            Spacer()
            chevron
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 25)
        .padding(.horizontal, 10)
        .cornerRadius(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: .black, radius: 2, x: 0, y: 2)
        )
        
    }
    
    @ViewBuilder
    private func eventInfoSection(imageName: String, info: String) -> some View {
        HStack(spacing: .zero) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 22, height: 20)
                .padding(.trailing, 5)
                .foregroundColor(themeManager.color(for: .brandGreen))
            Text(info)
                .foregroundColor(themeManager.color(for: .textSecondary))
        }
    }
    
    private var chevron: some View {
        Image(systemName: "chevron.right")
            .resizable()
            .frame(width: 20, height: 24)
            .foregroundColor(themeManager.color(for: .brandGreen))
            .padding(.trailing, 10)
    }
}

//
//  InitialDetailsView.swift
//  Establish
//
//  Created by Joshua Brown on 04/02/2022.
//

import Foundation
import SwiftUI

//Location Search
//https://kment-robin.medium.com/swiftui-location-search-with-mapkit-c64589990a66
struct InitalDetailsView: View {
    
    @ObservedObject private var viewModel: CreateEventViewModel
    private let themeManager: ThemeManager
    
    init(viewModel: CreateEventViewModel, themeManager: ThemeManager) {
        self.viewModel = viewModel
        self.themeManager = themeManager
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $viewModel.eventName)
                TextField("Location", text: $viewModel.eventLocation)
                DatePicker("Date of event", selection: $viewModel.eventDate, in: Date()...)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .accentColor(themeManager.color(for: .brandGreen))
            }
            
            Section {
                Button("Next", action: {
                    if !viewModel.shouldCreateButtonBeDisabled {
                        viewModel.currentScreen = .additionalDetails
                    }
                    return
                })
                .buttonStyle(ButtonStyle.Primary(themeManager: self.themeManager, isDisabled: viewModel.shouldCreateButtonBeDisabled))
            }
            .listRowBackground(Color.clear)
        }
    }
}

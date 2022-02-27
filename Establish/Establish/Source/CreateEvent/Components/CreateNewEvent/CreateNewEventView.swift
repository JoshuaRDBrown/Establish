//
//  CreateNewEventView.swift
//  Establish
//
//  Created by Joshua Brown on 04/02/2022.
//

import Foundation
import SwiftUI

struct CreateNewEventView: View {
    
    @ObservedObject private var viewModel: CreateNewEventViewModel
    private let themeManager: ThemeManager
    
    init(viewModel: CreateNewEventViewModel, themeManager: ThemeManager) {
        self.viewModel = viewModel
        self.themeManager = themeManager
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $viewModel.eventName)
                    HStack {
                        TextField("Location", text: $viewModel.eventLocation)
                        if viewModel.isLoadingMapData {
                            Spacer()
                            ProgressView()
                        }
                    }
                    
                    if !viewModel.locationServiceResults.isEmpty && !viewModel.hasPickedASuggestedLocation {
                        locationList
                    }
                    eventDatePicker
                }
                
                nextButton
            }
        }
       
    }
    
    private var locationList: some View {
        List {
            ScrollView {
                ForEach(viewModel.locationServiceResults, id: \.self) { location in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(location.title)
                                .font(.body)
                            Text(location.subtitle)
                                .font(.caption)
                            Divider()
                        }
                        Spacer()
                    }
                    .onTapGesture {
                        viewModel.eventLocation = "\(location.title + ", " + location.subtitle)"
                        viewModel.hasPickedASuggestedLocation = true
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 80, alignment: .leading)
        }
    }
    
    private var eventDatePicker: some View {
        DatePicker("Date of event", selection: $viewModel.eventDate, in: Date()...)
            .datePickerStyle(GraphicalDatePickerStyle())
            .accentColor(themeManager.color(for: .brandGreen))
    }
    
    private var nextButton: some View {
        Section {
            Button("Next", action: viewModel.didTapNext)
                .buttonStyle(ButtonStyle.Primary(themeManager: self.themeManager, isDisabled: viewModel.shouldCreateButtonBeDisabled))
        }
        .listRowBackground(Color.clear)
    }
}

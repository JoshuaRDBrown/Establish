//
//  AdditionalDetailsView.swift
//  Establish
//
//  Created by Joshua Brown on 04/02/2022.
//

import Foundation
import SwiftUI

enum RecurringDateSelection {
    case everyday
    case everyWeek
    case everyMonth
    case yearly
    case custom
}

struct AdditionalDetailsView: View {
    
    @ObservedObject private var viewModel: CreateEventViewModel
    
    @State private var showingMonzoLinkInfoAlert = false
    @State private var recurringEventSelection: RecurringDateSelection = .everyday
    
    private let monzoAlertTitle = "Paying with Monzo"
    private let monzoAlertMessage = "If your event requires a deposit to book, this option allows you to enter your Monzo payment link. This link will be shown in the event details as a required action for all participants."
    
    init(viewModel: CreateEventViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Form {
            Section {
                VStack {
                    HStack {
                        Text("Name:")
                        Spacer()
                        Text(viewModel.eventName)
                    }
                    
                    HStack {
                        Text("Location:")
                        Spacer()
                        Text(viewModel.eventLocation)
                    }
                    
                    HStack {
                        Text("Date:")
                        Spacer()
                        Text("22/05/22 @ 5:30PM")
                    }
                }
            }
            
            Section {
                HStack {
                    TextField("Tags (Max: 4)", text: $viewModel.currentlyInputtedTag)
                    Button("Add", action: { viewModel.addNewTag() })
                        .disabled(viewModel.storedTags.count == 4)
                }
                
                if !viewModel.storedTags.isEmpty {
                    HStack {
                        ForEach(viewModel.storedTags, id: \.self) { tag in
                            EventTagView(tagName: tag)
                                .onTapGesture { viewModel.removeTag(name: tag) }
                        }
                    }
                }
                
                HStack {
                    Text("Accept Payment?")
                    Image(systemName: "info.circle")
                        .foregroundColor(.blue)
                        .onTapGesture { self.showingMonzoLinkInfoAlert = true }
                    Spacer()
                    Toggle("", isOn: $viewModel.toggledMonzoLink)
                }
                
                if viewModel.toggledMonzoLink {
                    HStack {
                        TextField("Your Monzo payment link", text: $viewModel.monzoPaymentLink)
                        Spacer()
                        Image("monzo-logo")
                            .resizable()
                            .frame(width: 22, height: 22)
                            .onTapGesture { viewModel.openMonzoBlog() }
                    }
                }
                
                HStack {
                    Text("Recurring event")
                    Spacer()
                    Toggle("", isOn: $viewModel.toggledRecurringEvent)
                }
                
                if viewModel.toggledRecurringEvent {
                    HStack {
                        Picker("Pick an option", selection: $recurringEventSelection) {
                            Text("Everyday").tag(RecurringDateSelection.everyday)
                            Text("Every month on the \(viewModel.eventDayOfMonth)").tag(RecurringDateSelection.everyMonth)
                            Text("Every \(viewModel.eventDayOfWeek)").tag(RecurringDateSelection.everyWeek)
                            Text("Every year").tag(RecurringDateSelection.yearly)
                            Text("Custom").tag(RecurringDateSelection.custom)
                        }
                    }
                }
            }
        }
        .alert(isPresented: $showingMonzoLinkInfoAlert) {
            Alert(title: Text(monzoAlertTitle), message: Text(monzoAlertMessage), dismissButton: .default(Text("Ok")))
        }
    }
}

//
//  CreateEventView.swift
//  Establish
//
//  Created by Joshua Brown on 28/01/2022.
//

import Foundation
import SwiftUI

struct CreateEventView: View, ThemeManagerAccessProtocol {
    
    @ObservedObject private var viewModel: CreateEventViewModel
    
    @State private var showingMonzoLinkInfoAlert = false
    
    private let monzoAlertTitle = "Paying with Monzo"
    private let monzoAlertMessage = "If your event requires a deposit to book, this option allows you to enter your Monzo payment link. This link will be shown in the event details as a required action for all participants."
    
    init(viewModel: CreateEventViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        //Location Search
        //https://kment-robin.medium.com/swiftui-location-search-with-mapkit-c64589990a66
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $viewModel.eventName)
                    TextField("Location", text: $viewModel.eventLocation)
                    DatePicker("Date of event", selection: $viewModel.eventDate, in: Date()...)
                        .datePickerStyle(GraphicalDatePickerStyle())
                    HStack {
                        TextField("Tags", text: $viewModel.currentlyInputtedTag)
                        Button("Add", action: { })
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
                }
                
                Section {
                    Button("Create", action: { })
                        .buttonStyle(ButtonStyle.Primary(themeManager: self.themeManager))
                }
                .listRowBackground(Color.clear)
            }
            .alert(isPresented: $showingMonzoLinkInfoAlert) {
                Alert(title: Text(monzoAlertTitle), message: Text(monzoAlertMessage), dismissButton: .default(Text("Ok")))
            }
        }
    }
    
    private var doneButton: some View {
        Button("Done", action: { })
    }
}

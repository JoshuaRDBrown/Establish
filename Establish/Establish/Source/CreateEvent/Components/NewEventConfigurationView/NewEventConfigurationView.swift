//
//  NewEventConfigurationView.swift
//  Establish
//
//  Created by Joshua Brown on 04/02/2022.
//

import Foundation
import SwiftUI

struct NewEventConfigurationView: View {
    
    @ObservedObject private var viewModel: NewEventConfigurationViewModel
    @State private var showingMonzoLinkInfoAlert = false

    private let themeManager: ThemeManager
    private let sizes: Sizes
        
    init(viewModel: NewEventConfigurationViewModel, themeManager: ThemeManager, sizes: Sizes = Sizes()) {
        self.viewModel = viewModel
        self.themeManager = themeManager
        self.sizes = sizes
    }
    
    var body: some View {
        Form {
            eventInfo
            
            Section {
                eventTagsInput
                
                if !viewModel.storedTags.isEmpty {
                    eventTags
                }
                
                toggleablePaymentLinkInput
                toggleableRecurringEventInput
            }
            
            bottomButtons
        }
        .alert(isPresented: $showingMonzoLinkInfoAlert) {
            Alert(title: Text(viewModel.monzoAlertTitle), message: Text(viewModel.monzoAlertMessage), dismissButton: .default(Text("Ok")))
        }
    }
    
    private var eventInfo: some View {
        Section {
            VStack {
                eventInfoBannerSection(imageName: "note.text", textValue: viewModel.eventDetails.name)
                eventInfoBannerSection(imageName: "location.fill", textValue: viewModel.eventDetails.location)
                eventInfoBannerSection(imageName: "calendar.badge.clock", textValue: viewModel.eventFullDate)
            }
        }
    }
    
    private func eventInfoBannerSection(imageName: String, textValue: String) -> some View {
        HStack {
            Image(systemName: imageName)
                .resizable()
                .frame(width: sizes.infoBannerIconWidth, height: sizes.infoBannerIconHeight)
                .foregroundColor(themeManager.color(for: .brandGreen))
            Text(textValue)
                .font(.headline)
                .foregroundColor(themeManager.color(for: .textSecondary))
            Spacer()
        }
        .padding(.vertical, sizes.smallPadding)
    }
    
    private var eventTagsInput: some View {
        HStack {
            TextField("Tags (Max: 4)", text: $viewModel.currentlyInputtedTag)
            Button("Add", action: { viewModel.addNewTag() })
                .disabled(viewModel.storedTags.count == 4)
        }
    }
    
    private var eventTags: some View {
        HStack {
            ForEach(viewModel.storedTags, id: \.self) { tag in
                EventTagView(tagName: tag)
                    .onTapGesture { viewModel.removeTag(name: tag) }
            }
        }
    }
    
    private var toggleablePaymentLinkInput: some View {
        VStack {
            HStack {
                Text("Payment Required")
                Image(systemName: "info.circle")
                    .foregroundColor(.blue)
                    .onTapGesture { self.showingMonzoLinkInfoAlert = true }
                Spacer()
                Toggle("", isOn: $viewModel.toggledMonzoLink)
            }
        
            HStack {
                TextField("Monzo payment link", text: $viewModel.monzoPaymentLink)
                Spacer()
                Image("monzo-logo")
                    .resizable()
                    .frame(width: sizes.monzoLogoDimensions, height: sizes.monzoLogoDimensions)
                    .onTapGesture { viewModel.openMonzoBlog() }
            }
            .opacity(!viewModel.toggledMonzoLink ? 0.3 : 1)
            .disabled(!viewModel.toggledMonzoLink)
        }
    }
    
    private var toggleableRecurringEventInput: some View {
        VStack {
            HStack {
                Text("Recurring event")
                Spacer()
                Toggle("", isOn: $viewModel.toggledRecurringEvent)
            }
            
            VStack {
                recurrenceOption(text: "Everyday", selection: .everyday)
                recurrenceOption(text: "Every month on the \(viewModel.eventDayOfMonth)", selection: .everyMonth)
                recurrenceOption(text: "Every \(viewModel.eventDayOfWeek)", selection: .everyWeek)
                recurrenceOption(text: "Every year", selection: .yearly)
                recurrenceOption(text: "Custom", selection: .custom)
            }
            .opacity(!viewModel.toggledRecurringEvent ? 0.3 : 1)
            .disabled(!viewModel.toggledRecurringEvent)
        }
    }
    
    private var bottomButtons: some View {
        Section {
            VStack {
                Button("Create", action: viewModel.createEvent)
                    .buttonStyle(ButtonStyle.Primary(themeManager: self.themeManager, isDisabled: false))
                Button("Back to initial details", action: viewModel.didTapBack)
                    .foregroundColor(themeManager.color(for: .brandGreen))
            }
        }
        .listRowBackground(Color.clear)
    }
    
    private func recurrenceOption(text: String, selection: NewEventConfigurationViewModel.RecurringDateSelection) -> some View {
        HStack {
            CheckBoxView(checkedColor: themeManager.color(for: .brandGreen), isChecked: viewModel.recurringEventSelection == selection, shape: .square, width: sizes.checkboxDimensions, height: sizes.checkboxDimensions, themeManager: self.themeManager)
            Text(text)
            Spacer()
        }
        .padding(.bottom, sizes.smallPadding)
        .onTapGesture { viewModel.recurringEventSelection = selection }
    }
    
    struct Sizes {
        let smallPadding: CGFloat
        let monzoLogoDimensions: CGFloat
        let infoBannerIconWidth: CGFloat
        let infoBannerIconHeight: CGFloat
        let checkboxDimensions: CGFloat
        
        init(smallPadding: CGFloat = 5,
             monzoLogoDimensions: CGFloat = 22,
             infoBannerIconWidth: CGFloat = 22,
             infoBannerIconHeight: CGFloat = 20,
             checkboxDimensions: CGFloat = 20) {
            self.smallPadding = smallPadding
            self.monzoLogoDimensions = monzoLogoDimensions
            self.infoBannerIconWidth = infoBannerIconWidth
            self.infoBannerIconHeight = infoBannerIconHeight
            self.checkboxDimensions = checkboxDimensions
        }
    }
}

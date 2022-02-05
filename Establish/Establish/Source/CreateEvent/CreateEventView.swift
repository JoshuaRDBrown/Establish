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
    
    init(viewModel: CreateEventViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.currentScreen == .initialDetails {
                    InitalDetailsView(viewModel: viewModel, themeManager: self.themeManager)
                } else {
                    AdditionalDetailsView(viewModel: viewModel)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Cancel", action: viewModel.dismissView))
            .navigationTitle("Create event")
        }
    }
}

//
//  SharableCodeView.swift
//  Establish
//
//  Created by Joshua Brown on 06/02/2022.
//

import SwiftUI

//struct SharableCodeView: View, ThemeManagerAccessProtocol {
//
//    @ObservedObject private var viewModel: CreateEventViewModel
//
//    init(viewModel: CreateEventViewModel) {
//        self.viewModel = viewModel
//    }
//
//    var body: some View {
//        ZStack(alignment:.topLeading) {
//            VStack {
//                LottieAnimationView(assetName: "success")
//                eventSummary
//            }
//        }
//    }
//
//    private var eventSummary: some View {
//        VStack {
//            Text("Event created!")
//                .font(.title)
//
//            VStack {
//                Text(viewModel.eventName)
//                Text(viewModel.eventLocation)
//                Text(viewModel.eventFullDate)
//            }
//            .font(.title3)
//            .padding([.horizontal, .bottom], 5)
//            .foregroundColor(themeManager.color(for: .textSecondary))
//
//            HStack {
//                Text("Event code: ")
//                Text("A66GQLP67")
//                    .onTapGesture {
//                        let textMessageString = "sms:123456&body=Join this event with this code! A66GQLP67"
//                        guard let url = URL(string: textMessageString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
//                            return
//                        }
//                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                    }
//                    .foregroundColor(.blue)
//            }
//            .font(.title3)
//
//            Button("Continue", action: { viewModel.navigateToNewlyCreatedEvent(id: "12345") })
//                .buttonStyle(ButtonStyle.Primary(themeManager: self.themeManager))
//                .padding()
//        }
//    }
// }

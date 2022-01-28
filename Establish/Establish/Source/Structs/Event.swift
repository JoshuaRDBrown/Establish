//
//  Event.swift
//  Establish
//
//  Created by Joshua Brown on 26/01/2022.
//

import Foundation
import SwiftUI

public struct EventTag {
    public let name: String
    public let color: Color
}

public struct ChatLogItem {
    public let sender: String
    public let timeSent: Date
    public let message: String
    //How to make this dymanic for polls etc?
}

public struct Event {
    public let accessCode: String
    public let name: String
    public let date: String
    public let imageURL: String
    public let attendeeNames: [String]
    public let tags: [EventTag]
    public let owner: String
    public let chatLog: [ChatLogItem]
}

//
//  EventPayload.swift
//  Establish
//
//  Created by Joshua Brown on 27/02/2022.
//

import Foundation

public struct EventPayload: Identifiable {
    public let id = UUID()
    public let accessCode: String
    public let name: String
    public let location: String
    public let date: TimeInterval
    public let isRecurring: Bool
    public let recurringType: String?
    public let monzoLink: String?
    public let creator: String
    public let tags: [String]
    public let attendees: [Attendee]
}

public struct Attendee {
    public let name: String
    public let imageURL: String
    public let status: AttendeeStatus
}

public enum AttendeeStatus {
    case attending
    case declined
    case maybe
}

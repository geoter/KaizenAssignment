//
//  SportsResponse.swift
//  KaizenAssignment
//
//  Created by George Termentzoglou on 10/9/22.
//

import Foundation

struct SportModel: Decodable {
    let sportId: String
    let sportName: String
    let events: [SportEvent]
    
    enum CodingKeys: String, CodingKey {
        case sportId = "i"
        case sportName = "d"
        case events = "e"
    }
}

struct SportEvent: Decodable {
    let eventId: String //TODO: ask backend if its safe to convert it to Int to make comparisons faster
    let sportId: String //TODO: ask backend if its safe to convert it to Int to make comparisons faster
    let eventName: String
    let eventStartTimestamp: Int //unix time
    
    enum CodingKeys: String, CodingKey {
        case eventId = "i"
        case sportId = "si"
        case eventName = "d"
        case eventStartTimestamp = "tt"
    }
}

//
//  Trip.swift
//  leavetracker-ai
//
//  Created by Esme Putt on 9/06/24.
//

import Foundation

struct Trip: Identifiable, Equatable {
    let id: UUID
    var name: String
    var status: TripStatus
    var startDate: Date
    var endDate: Date

    enum TripStatus: String, CaseIterable, Identifiable {
        case confirmed = "Confirmed"
        case pending = "Pending"
        case idea = "Idea"
        
        var id: String { self.rawValue }
    }
}

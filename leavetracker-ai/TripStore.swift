//
//  TripStore.swift
//  leavetracker-ai
//
//  Created by Esme Putt on 9/06/24.
//

import Foundation

class TripStore: ObservableObject {
    @Published var trips: [Trip] = []
}

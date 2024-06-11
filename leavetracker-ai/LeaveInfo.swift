//
//  LeaveInfo.swift
//  leavetracker-ai
//
//  Created by Esme Putt on 9/06/24.
//

import Foundation

class LeaveInfo: ObservableObject {
    @Published var annualLeaveWeeks: String = "4"
    @Published var hoursPerWeek: String = "40"
}

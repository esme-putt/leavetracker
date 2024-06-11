//
//  LeaveBalanceData.swift
//  leavetracker-ai
//
//  Created by Esme Putt on 9/06/24.
//

import Foundation

struct LeaveBalanceData: Identifiable {
    let id = UUID()
    let date: Date
    let balance: Double
}

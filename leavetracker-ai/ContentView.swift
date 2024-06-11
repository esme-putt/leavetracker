//
//  ContentView.swift
//  leavetracker-ai
//
//  Created by Esme Putt on 9/06/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var tripStore = TripStore()
    @StateObject var leaveInfo = LeaveInfo()
    @StateObject var nonLeaveDateStore = NonLeaveDateStore()

    var body: some View {
        TabView {
            DashboardView(leaveInfo: leaveInfo, tripStore: tripStore, nonLeaveDateStore: nonLeaveDateStore)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            TripListView(tripStore: tripStore)
                .tabItem {
                    Label("Leave", systemImage: "paperplane")
                }
            
            NonLeaveDateListView(nonLeaveDateStore: nonLeaveDateStore)
                .tabItem {
                    Label("Holidays", systemImage: "clock")
                }
            
            LeaveInfoForm(leaveInfo: leaveInfo)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

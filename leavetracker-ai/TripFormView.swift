//
//  TripFormView.swift
//  leavetracker-ai
//
//  Created by Esme Putt on 9/06/24.
//

import SwiftUI

struct TripFormView: View {
    @Binding var trip: Trip
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                TextField("Trip Name", text: $trip.name)
                
                Picker("Status", selection: $trip.status) {
                    ForEach(Trip.TripStatus.allCases) { status in
                        Text(status.rawValue).tag(status)
                    }
                }
                
                DatePicker("Start Date", selection: $trip.startDate, displayedComponents: .date)
                DatePicker("End Date", selection: $trip.endDate, displayedComponents: .date)
                
                Button("Save") {
                    presentationMode.wrappedValue.dismiss()
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .navigationBarTitle("Trip Details", displayMode: .inline)
        }
    }
}

struct TripFormView_Previews: PreviewProvider {
    @State static var trip = Trip(id: UUID(), name: "", status: .confirmed, startDate: Date(), endDate: Date())
    
    static var previews: some View {
        TripFormView(trip: $trip)
    }
}

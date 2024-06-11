import SwiftUI

struct TripListView: View {
    @ObservedObject var tripStore: TripStore
    @State private var showingAddTrip = false
    @State private var newTrip = Trip(id: UUID(), name: "", status: .idea, startDate: Date(), endDate: Date())

    var body: some View {
        NavigationView {
            List {
                ForEach($tripStore.trips) { $trip in
                    NavigationLink(destination: TripFormView(trip: $trip)) {
                        VStack(alignment: .leading) {
                            Text(trip.name)
                                .font(.headline)
                            Text(trip.status.rawValue)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteTrip)
            }
            .navigationBarTitle("Upcoming leave")
            .navigationBarItems(trailing: Button(action: {
                showingAddTrip = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddTrip) {
                TripFormView(trip: $newTrip)
                    .onDisappear {
                        if newTrip.name.isEmpty == false {
                            tripStore.trips.append(newTrip)
                            newTrip = Trip(id: UUID(), name: "", status: .idea, startDate: Date(), endDate: Date())
                        }
                    }
            }
        }
    }

    func deleteTrip(at offsets: IndexSet) {
        tripStore.trips.remove(atOffsets: offsets)
    }
}

struct TripListView_Previews: PreviewProvider {
    static var previews: some View {
        TripListView(tripStore: TripStore())
    }
}

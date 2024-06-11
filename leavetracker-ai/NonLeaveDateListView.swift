import SwiftUI

struct NonLeaveDateListView: View {
    @ObservedObject var nonLeaveDateStore: NonLeaveDateStore
    @State private var showingAddDate = false
    @State private var newDate = Date()
    @State private var newDescription = ""

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach($nonLeaveDateStore.nonLeaveDates) { $date in
                        HStack {
                            Text(date.description)
                            Spacer()
                            Text(date.date, style: .date)
                        }
                    }
                    .onDelete(perform: deleteDate)
                }
                .navigationBarTitle("Non-Leave Dates")
                .navigationBarItems(trailing: Button(action: {
                    showingAddDate = true
                }) {
                    Image(systemName: "plus")
                })
                .sheet(isPresented: $showingAddDate) {
                    VStack {
                        DatePicker("Select Date", selection: $newDate, displayedComponents: .date)
                            .padding()
                            .datePickerStyle(WheelDatePickerStyle())

                        TextField("Description", text: $newDescription)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()

                        Button("Add Date") {
                            if !newDescription.isEmpty {
                                let newNonLeaveDate = NonLeaveDate(date: newDate, description: newDescription)
                                nonLeaveDateStore.nonLeaveDates.append(newNonLeaveDate)
                                newDate = Date()
                                newDescription = ""
                                showingAddDate = false
                            }
                        }
                        .padding()
                    }
                    .padding()
                }
            }
        }
    }

    func deleteDate(at offsets: IndexSet) {
        nonLeaveDateStore.nonLeaveDates.remove(atOffsets: offsets)
    }
}

struct NonLeaveDateListView_Previews: PreviewProvider {
    static var previews: some View {
        NonLeaveDateListView(nonLeaveDateStore: NonLeaveDateStore())
    }
}

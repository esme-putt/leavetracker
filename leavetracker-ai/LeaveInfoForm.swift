import SwiftUI

struct LeaveInfoForm: View {
    @ObservedObject var leaveInfo: LeaveInfo
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Text("Weeks of annual leave entitled")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Weeks", text: $leaveInfo.annualLeaveWeeks)
                        .keyboardType(.numberPad)
                        .padding()
                }
                HStack {
                    Text("Hours worked per week")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Hours", text: $leaveInfo.hoursPerWeek)
                        .keyboardType(.numberPad)
                        .padding()
                }
                VStack {
                    Text("Regular working days")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical)
                    HStack {
                        Button("Mon") { }
                            .frame(maxWidth: 60, maxHeight: 40)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .cornerRadius(4)
                        Button("Tues") { }
                            .frame(maxWidth: 60, maxHeight: 40)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .cornerRadius(4)
                        Button("Wed") { }
                            .frame(maxWidth: 60, maxHeight: 40)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .cornerRadius(4)
                        Button("Thur") { }
                            .frame(maxWidth: 60, maxHeight: 40)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .cornerRadius(4)
                        Button("Fri") { }
                            .frame(maxWidth: 60, maxHeight: 40)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .cornerRadius(4)
                    }
                }
                            
                Button("Save") {
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
            }
            .navigationBarTitle("Leave information", displayMode: .inline)
        }
    }

    func saveLeaveInfo() {
        // Save leave information logic if needed

    }
}

struct LeaveInfoForm_Previews: PreviewProvider {
    @StateObject static var leaveInfo = LeaveInfo()
    
    static var previews: some View {
        LeaveInfoForm(leaveInfo: leaveInfo)
    }
}

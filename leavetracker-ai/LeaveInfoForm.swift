import SwiftUI

struct LeaveInfoForm: View {
    @ObservedObject var leaveInfo: LeaveInfo

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Leave Information")
                            .font(.headline)
                            .foregroundColor(.primary)) {
                    TextField("Weeks of Annual Leave", text: $leaveInfo.annualLeaveWeeks)
                        .keyboardType(.numberPad)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    
                    TextField("Hours Worked Per Week", text: $leaveInfo.hoursPerWeek)
                        .keyboardType(.numberPad)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                }

                Button(action: saveLeaveInfo) {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.top)
                }
            }
            .navigationBarTitle("Enter Leave Info", displayMode: .inline)
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

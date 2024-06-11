import SwiftUI

struct LeaveInfoForm: View {
    @ObservedObject var leaveInfo: LeaveInfo
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Weeks of Annual Leave", text: $leaveInfo.annualLeaveWeeks)
                    .keyboardType(.numberPad)
                    .padding()
                
                TextField("Hours Worked Per Week", text: $leaveInfo.hoursPerWeek)
                    .keyboardType(.numberPad)
                    .padding()
                
                Button("Save") {
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
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

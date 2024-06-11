
import SwiftUI
import SwiftUICharts

struct DashboardView: View {
    @ObservedObject var leaveInfo: LeaveInfo
    @ObservedObject var tripStore: TripStore
    @ObservedObject var nonLeaveDateStore: NonLeaveDateStore
    
    @State private var selectedDate = Date()
    @State private var currentBalance: String = "0"
    @State private var remainingLeave: Double = 0.0
    @State private var appliedLeave: Double = 0.0
    @State private var leaveBalanceData: [(String, Double)] = []

    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                ScrollView {
                    HStack {
                        Text("Current leave balance (in hours)")
                            .padding(.vertical, 10)
                        TextField("Current leave balance (in hours)", text: $currentBalance)
                            .padding() // Add padding inside the text field
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1) // Add gray border
                            )
                    }
                    .padding(.vertical, 10)
                    
                    DatePicker("Projected date", selection: $selectedDate, displayedComponents: .date)
                        .padding(.vertical, 10)
                    
                    Text("Projected balance: \(calculateProjectedBalance(for: selectedDate), specifier: "%.2f") hours")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.backgroundColor)
                        .cornerRadius(10)
                        .padding(.vertical, 10)
                    
                    // MARK: Chart
                    if !leaveBalanceData.isEmpty {
                        CardView {
                            VStack(alignment: .leading) {
                                ChartLabel(currentBalance, type: .legend, format: "%.02f hours projected")
                                LineChart()
                            }
                            .background(Color.backgroundColor)
                        }
                        .data(leaveBalanceData)
                        .chartStyle(ChartStyle(backgroundColor: Color.backgroundColor, foregroundColor: ColorGradient(Color.primaryColor.opacity(0.4), Color.primaryColor)))
                        .frame(height: 300)
                        .padding(.vertical, 10)
                    }
                }
            }
            .padding()
            .navigationBarTitle("Leave projection", displayMode: .large)
            .onAppear(perform: updateLeaveBalanceData)
            .onChange(of: currentBalance, perform: { _ in updateLeaveBalanceData() })
            .onChange(of: selectedDate, perform: { _ in updateLeaveBalanceData() })
            .onChange(of: leaveInfo.annualLeaveWeeks, perform: { _ in updateLeaveBalanceData() })
            .onChange(of: leaveInfo.hoursPerWeek, perform: { _ in updateLeaveBalanceData() })
            .onChange(of: tripStore.trips, perform: { _ in updateLeaveBalanceData() })
            .onChange(of: nonLeaveDateStore.nonLeaveDates, perform: { _ in updateLeaveBalanceData() })
        }
    }

    func updateLeaveBalanceData() {
        // Reset all data
        leaveBalanceData.removeAll()

        let calendar = Calendar.current
        let today = Date()
        
        // Only hold data from now until a year from now
        let timeFromNow = calendar.date(byAdding: .month, value: 3, to: today) ?? today
        let daysInYear = calendar.dateComponents([.day], from: today, to: timeFromNow).day ?? 0

        var currentDate = today
        for _ in 0..<daysInYear {
            // Calculate project balance for this date
            leaveBalanceData.append((currentDate.formatted(), calculateProjectedBalance(for: currentDate)))

            // Iterate every two weeks
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
        }
    }
    
    func datesOnLeave(trips: [Trip], nonLeaveDates: [NonLeaveDate]) -> Set<Date> {
        let calendar = Calendar.current
        var datesOnLeave = Set<Date>()
        
        // Go through every trip and add the dates included in it
        trips.forEach { trip in
            var current = trip.startDate
            while current <= trip.endDate {
                // First, check the date is a weekend
                if calendar.isDateInWeekend(current) == false && 
                    !(nonLeaveDates.contains(where: { $0.date == current })) {
                    datesOnLeave.insert(current)
                }
                current = calendar.date(byAdding: .day, value: 1, to: current)!
            }
        }
        return datesOnLeave
    }
    
    func calculateProjectedBalance(for date: Date) -> Double {
        guard let annualLeaveWeeks = Double(leaveInfo.annualLeaveWeeks),
              let hoursPerWeek = Double(leaveInfo.hoursPerWeek),
              let currentLeaveBalance = Double(currentBalance) else {
            return 0
        }

        let calendar = Calendar.current
        let today = Date()
        let daysInFuture = calendar.dateComponents([.day], from: today, to: date).day ?? 0
        let daysOnLeave = datesOnLeave(trips: tripStore.trips, nonLeaveDates: nonLeaveDateStore.nonLeaveDates)
        
        var leaveCounted = daysOnLeave.filter { leaveDate in
            // Leave is in the future (greater than today), but occured before the projected date
            // (less than 'date')
            date >= leaveDate && leaveDate >= today
        }
        
        let numberOfDaysOnLeave = Double(leaveCounted.count)
        let numberOfHoursOnLeave = numberOfDaysOnLeave * Double(hoursPerWeek) / 5
        let leaveAccumulatedPerDay = annualLeaveWeeks / 365 * hoursPerWeek
        let leaveAccumulated = leaveAccumulatedPerDay * Double(daysInFuture)
        
        return leaveAccumulated + currentLeaveBalance - numberOfHoursOnLeave
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(leaveInfo: LeaveInfo(), tripStore: TripStore(), nonLeaveDateStore: NonLeaveDateStore())
    }
}

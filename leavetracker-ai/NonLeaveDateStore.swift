import Foundation

class NonLeaveDateStore: ObservableObject {
    @Published var nonLeaveDates: [NonLeaveDate] = []

    init() {
        self.nonLeaveDates = self.prepopulatePublicHolidays()
    }

    func prepopulatePublicHolidays() -> [NonLeaveDate] {
        var publicHolidays: [NonLeaveDate] = []
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())

        for year in currentYear...(currentYear + 2) {
            publicHolidays.append(contentsOf: [
                NonLeaveDate(date: calendar.date(from: DateComponents(year: year, month: 1, day: 1))!, description: "New Year's Day"),
                NonLeaveDate(date: calendar.date(from: DateComponents(year: year, month: 1, day: 2))!, description: "Day after New Year's Day"),
                NonLeaveDate(date: calendar.date(from: DateComponents(year: year, month: 2, day: 6))!, description: "Waitangi Day"),
                NonLeaveDate(date: calendar.date(from: DateComponents(year: year, month: 4, day: 25))!, description: "Anzac Day"),
                NonLeaveDate(date: calendar.date(from: DateComponents(year: year, month: 6, day: 7))!, description: "Queen's Birthday"),
                NonLeaveDate(date: calendar.date(from: DateComponents(year: year, month: 10, day: 24))!, description: "Labour Day"),
                NonLeaveDate(date: calendar.date(from: DateComponents(year: year, month: 12, day: 25))!, description: "Christmas Day"),
                NonLeaveDate(date: calendar.date(from: DateComponents(year: year, month: 12, day: 26))!, description: "Boxing Day")
            ])
        }

        return publicHolidays
    }
}

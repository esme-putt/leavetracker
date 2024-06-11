import Foundation

struct NonLeaveDate: Identifiable, Equatable {
    let id = UUID()
    let date: Date
    let description: String
}

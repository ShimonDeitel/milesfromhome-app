import Foundation

struct TripRecord: Identifiable, Codable, Equatable {
    let id: UUID
    var tripName: String
    var distanceFromHome: Double
    var date: Date
    var notes: String

    init(id: UUID = UUID(), tripName: String, distanceFromHome: Double, date: Date, notes: String) {
        self.id = id
        self.tripName = tripName
        self.distanceFromHome = distanceFromHome
        self.date = date
        self.notes = notes
    }
}

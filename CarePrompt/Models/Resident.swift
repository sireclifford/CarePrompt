import Foundation
import SwiftData

@Model
final class Resident {
    var id: UUID
    var name: String
    var dateAdded: Date
    var unit: String
    var roomNumber: String
    var preferredLanguage: String
    var photoData: Data?
    var externalID: String?
    
    @Relationship(deleteRule: .cascade, inverse: \Symbol.resident)
    var symbols: [Symbol] = []
    
    init(name: String, unit: String, roomNumber: String, preferredLanguage: String = "en-CA", photoData: Data? = nil, externalID: String? = nil) {
        self.id = UUID()
        self.name = name
        self.dateAdded = .now
        self.unit = unit
        self.roomNumber = roomNumber
        self.preferredLanguage = preferredLanguage
        self.photoData = photoData
        self.externalID = externalID
    }
}

import Foundation
import SwiftData

@Model
final class Symbol {
    var id: UUID
    var text: String
    var iconName: String
    var sortOrder: Int
    var resident: Resident?
    
    init(text: String, iconName: String, sortOrder: Int, resident: Resident? = nil){
        self.id = UUID()
        self.text = text
        self.iconName = iconName
        self.sortOrder = sortOrder
        self.resident = resident
    }
}

import Foundation

enum DementiaStage: String, CaseIterable {
    case early = "early"
    case middle = "middle"
    case late = "late"
    
    var displayName: String {
        switch self {
        case .early:
            return "Early Stage"
        case .middle:
            return "Middle Stage"
        case .late:
            return "Late Stage"
        }
    }
    
    var symbolsPerRow: Int {
        switch self {
        case .early: return 2
        case .middle: return 2
        case .late: return 1
            
        }
    }
    
    var showsTextLabel: Bool {
        switch self {
        case .early: return true
        case .middle: return true
        case .late: return false
        }
    }
    
    var cardSize: CGFloat {
        switch self {
        case .early: return 150
        case .middle: return 180
        case .late: return 260
        }
    }
    
}

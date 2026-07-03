import Foundation
import UIKit

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
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
        switch self {
        case .early: return isIpad ? 3 : 2
        case .middle: return isIpad ? 2 : 2
        case .late: return isIpad ? 1 : 1
            
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
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
        switch self {
        case .early: return isIpad ? 220 : 150
        case .middle: return isIpad ? 260 : 180
        case .late: return isIpad ? 360 : 260
        }
    }
    
}

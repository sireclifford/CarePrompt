//
//  Item.swift
//  CarePrompt
//
//  Created by Clifford Owusu on 2026-06-30.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

import Foundation
import SwiftData

@MainActor
func seedDataIfNeeded(context: ModelContext) throws {
    
    let existingResidents = try context.fetch(FetchDescriptor<Resident>())
    guard existingResidents.isEmpty else { return }
    
    let mary = Resident(
        name: "Mary Obrien",
        unit: "Reedwood Cottage",
        roomNumber: "5",
        preferredLanguage: "en-CA"
    )
    
    let marySymbols = [
        Symbol(text: "Water", iconName: "drop.fill", sortOrder: 0),
        Symbol(text: "Bathroom", iconName: "figure.walk", sortOrder: 1),
        Symbol(text: "Pain", iconName: "waveform.path.ecg", sortOrder: 2),
        Symbol(text: "Cold", iconName: "thermometer.snowflake", sortOrder: 3),
        Symbol(text: "Hungry", iconName: "fork.knife", sortOrder: 4),
        Symbol(text: "Tired", iconName: "moon.fill", sortOrder: 5)
    ]
    
    marySymbols.forEach { symbol in
        symbol.resident = mary
        context.insert(symbol)
    }
    context.insert(mary)
    
    let james = Resident(
        name: "James Tłı̨chǫ",
        unit: "Reedwood Cottage",
        roomNumber: "11",
        preferredLanguage: "en-CA"
    )
    
    let jamesSymbols = [
        Symbol(text: "Water", iconName: "drop.fill", sortOrder: 0),
        Symbol(text: "Bathroom", iconName: "figure.walk", sortOrder: 1),
        Symbol(text: "Help", iconName: "hand.raised.fill", sortOrder: 2),
        Symbol(text: "Hot", iconName: "thermometer.sun.fill", sortOrder: 3),
        Symbol(text: "Medicine", iconName: "pill.fill", sortOrder: 4),
        Symbol(text: "Family", iconName: "figure.2.and.child.holdinghands", sortOrder: 5)
    ]
    
    jamesSymbols.forEach { symbol in
        symbol.resident = james
        context.insert(symbol)
    }
    context.insert(james)
}

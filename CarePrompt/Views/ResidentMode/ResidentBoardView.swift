import SwiftUI

struct ResidentBoardView: View {
    let resident: Resident
    
    @AppStorage("dementiaStage") private var stageRaw: String = DementiaStage.early.rawValue
    
    var stage: DementiaStage {
        DementiaStage(rawValue: stageRaw) ?? .early
    }
    
    var sortedSymbols: [Symbol] {
        resident.symbols.sorted { $0.sortOrder < $1.sortOrder}
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns, spacing: 16) {
                ForEach(sortedSymbols) { symbol in
                    SymbolCardView(symbol: symbol, stage: stage)
                }
            }
            .padding(16)
        }
        .navigationTitle(resident.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var gridColumns: [GridItem] {
        Array (
            repeating: GridItem(.flexible(), spacing: 16),
            count: stage.symbolsPerRow
        )
    }
}

import SwiftUI
import SwiftData


struct ResidentBoardView: View {
    let resident: Resident
    
    @State private var showingAddSymbol = false
    @State private var symbolToDelete: Symbol?
    @State private var showingDeleteAlert = false
    
    @AppStorage("dementiaStage") private var stageRaw: String = DementiaStage.early.rawValue
    @AppStorage("caregiverEditMode") private var caregiverEditMode: Bool = false
    
    @Environment(\.modelContext) private var modelContext
    
    var stage: DementiaStage {
        DementiaStage(rawValue: stageRaw) ?? .early
    }
    
    var sortedSymbols: [Symbol] {
        (resident.symbols ?? []).sorted { $0.sortOrder < $1.sortOrder}
    }
    
    var body: some View {
        Group {
            if sortedSymbols.isEmpty {
                EmptyBoardView(residentName: resident.name)
            } else {
                ScrollView {
                    LazyVGrid(columns: gridColumns, spacing: 16) {
                        ForEach(sortedSymbols) { symbol in
                            SymbolCardView(symbol: symbol, stage: stage, language: resident.preferredLanguage)
                                .overlay(alignment: .topTrailing) {
                                    deleteBadge(for: symbol)
                                }
                        }
                    }
                    .padding(16)
                }
            }
        }
        .navigationTitle(resident.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing){
                Image(systemName: caregiverEditMode ? "lock.open.fill" : "lock.fill")
                    .foregroundStyle(caregiverEditMode ? Color.orange : Color.secondary)
            }
            if caregiverEditMode {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddSymbol = true
                    }label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddSymbol) {
            AddSymbolView(resident: resident)
        }
        .alert("Delete Symbol", isPresented: $showingDeleteAlert, presenting: symbolToDelete) { symbol in
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                modelContext.delete(symbol)
            }
        } message: { symbol in
            Text("Delete \"\(symbol.text)\" from \(resident.name)'s board?")
        }
    }
    
    var gridColumns: [GridItem] {
        Array (
            repeating: GridItem(.flexible(), spacing: 16),
            count: stage.symbolsPerRow
        )
    }

    @ViewBuilder
    private func deleteBadge(for symbol: Symbol) -> some View {
        if caregiverEditMode {
            Button {
                symbolToDelete = symbol
                showingDeleteAlert = true
            } label: {
                Image(systemName: "minus.circle.fill")
                    .foregroundStyle(.red)
                    .background(Circle().fill(.white))
            }
            .offset(x: 8, y: -8)
        }
    }
}

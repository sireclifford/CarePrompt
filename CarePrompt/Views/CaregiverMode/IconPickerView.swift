import SwiftUI

struct IconPickerView: View {
    @Binding var selectedIcon: String
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    
    var filteredSymbols: [String] {
        if searchText.isEmpty {
            return SFSymbolsLibrary.all
        }
        
        return SFSymbolsLibrary.all.filter {
            $0.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 5)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(filteredSymbols, id: \.self) { symbolName in
                        Button {
                            selectedIcon = symbolName
                            dismiss()
                        } label: {
                            ImageSymbol(symbolName: symbolName)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(16)
            }
            .navigationTitle("Choose Icon")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "Search symbols")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
    
    
    @ViewBuilder
    private func ImageSymbol(symbolName: String) -> some View {
        VStack(spacing: 4) {
            Image(systemName: symbolName)
                .font(.system(size: 28))
                .foregroundStyle(selectedIcon == symbolName ? .white : Color.accentColor)
                .frame(width: 60, height: 60)
                .background(selectedIcon == symbolName ? Color.accentColor : Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Text(symbolName
                .replacingOccurrences(of: ".fill", with: "")
                .replacingOccurrences(of: ".", with: " "))
            .font(.system(size: 9))
            .foregroundStyle(.secondary)
            .lineLimit(1)
            .minimumScaleFactor(0.7)
        }
    }
    
}

import SwiftUI
import SwiftData

struct AddSymbolView: View {
    let resident: Resident
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var text = ""
    @State private var selectedIcon = "star.fill"
    @State private var showingIconPicker = false
    @State private var showingValidationAlert = false
    
    var isFormValid: Bool {
        !text.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var nextSortOrder: Int {
        (resident.symbols?.map { $0.sortOrder }.max() ?? -1) + 1
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Symbol Text") {
                    TextField("e.g. Water, Bathroom, Pain", text: $text)
                }
                
                Section("Icon") {
                    Button {
                        showingIconPicker = true
                    } label: {
                        HStack {
                            Image(systemName: selectedIcon)
                                .font(.system(size: 28))
                                .foregroundStyle(Color.accentColor)
                                .frame(width: 44, height: 44)
                                .background(Color(.systemGray6))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Selected Icon")
                                    .font(.subheadline)
                                    .foregroundStyle(.primary)
                                Text(selectedIcon)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundStyle(.tertiary)
                        }
                        .frame(maxWidth: .infinity)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
            }
            .navigationTitle("Add Symbol")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        guard isFormValid else {
                            showingValidationAlert = true
                            return
                        }
                        saveSymbol()
                    }
                }
            }
            .sheet(isPresented: $showingIconPicker) {
                IconPickerView(selectedIcon: $selectedIcon)
            }
            .alert("Missing Information", isPresented: $showingValidationAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Please enter a text label for this symbol.")
            }
        }
    }
    
    private func saveSymbol() {
        let symbol = Symbol(
            text: text.trimmingCharacters(in: .whitespaces),
            iconName: selectedIcon,
            sortOrder: nextSortOrder
        )
        symbol.resident = resident
        modelContext.insert(symbol)
        dismiss()
    }
}

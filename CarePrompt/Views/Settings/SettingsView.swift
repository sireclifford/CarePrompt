import SwiftUI
import SwiftData

struct SettingsView: View {
    @AppStorage("dementiaStage") private var stageRaw: String = DementiaStage.early.rawValue
    @AppStorage("caregiverEditMode") private var caregiverEditMode: Bool = false
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var showingResetAlert: Bool = false
    
    var selectedStage: Binding<DementiaStage> {
        Binding(
            get: { DementiaStage(rawValue: stageRaw) ?? .early },
            set: { stageRaw = $0.rawValue }
        )
    }
    
    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Communication Mode") {
                    Picker("Dementia Stage", selection: selectedStage){
                        ForEach(DementiaStage.allCases, id: \.self) { stage in
                            Text(stage.displayName).tag(stage)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    stageDescriptionView
                }
                
                Section("Edit Mode") {
                    Toggle(isOn: $caregiverEditMode) {
                        Label("Caregiver Edit Mode", systemImage: caregiverEditMode ? "lock.open.fill" : "lock.fill")
                    }
                    .tint(Color.accentColor)
                    
                    Text(caregiverEditMode ? "Editing enabled - caregiver can add and delete symbols" : "Editing disabled - board is locked for resident use.")
                        .font(.caption)
                        .foregroundStyle(Color.secondary)
                }
                
                Section("About") {
                    LabeledContent("App", value: "Care Prompt")
                    LabeledContent("Version", value: appVersion)
                    LabeledContent("Purpose", value: "Non-verbal communication aid for dementia care")
                }
                
                Section("Data") {
                    Button(role: .destructive) {
                        showingResetAlert = true
                    } label: {
                        Label("Reset All Data", systemImage: "trash")
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done"){dismiss()}
                }
            }.alert("Reset All Data", isPresented: $showingResetAlert) {
                Button("Cancel", role: .cancel){}
                Button("Reset", role: .destructive) { resetAllData()}
            } message: {
                Text("This will permanently delete all residents and symbols. This action cannot be undone.")
            }
        }
    }
    
    @ViewBuilder
    private var stageDescriptionView: some View {
        switch selectedStage.wrappedValue {
        case .early:
            Text("2 symbols per row, text labels visible, standard card size.")
                .font(.caption)
                .foregroundStyle(.secondary)
        case .middle:
            Text("2 symbols per row, text labels visible, larger card size.")
                .font(.caption)
                .foregroundStyle(.secondary)
        case .late:
            Text("1 symbol per row, no text labels, maximum card size.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
    
    private func resetAllData() {
        do {
            try modelContext.delete(model: Resident.self)
            try modelContext.delete(model: Symbol.self)
        } catch {
            print("Reset error: \(error)")
        }
    }
}

import SwiftUI
import SwiftData

struct ResidentListView: View {
    @Query private var residents: [Resident]
    @State private var searchText = ""
    @State private var residentToDelete: Resident?
    @State private var showingDeleteAlert = false
    @State private var showingAddResident = false
    @State private var showingSettings = false

    @Environment(\.modelContext) private var modelContext

    init() {
        _residents = Query(sort: \Resident.roomNumber, order: .forward)
    }

    var filteredResidents: [Resident] {
        let sorted = residents.sorted {
            $0.roomNumber.localizedStandardCompare($1.roomNumber) == .orderedAscending
        }
        if searchText.isEmpty {
            return sorted
        }
        return sorted.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.roomNumber.localizedCaseInsensitiveContains(searchText) ||
            $0.unit.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            Group {
                if filteredResidents.isEmpty {
                    EmptyResidentListView()
                } else {
                    List {
                        ForEach(filteredResidents) { resident in
                            NavigationLink(destination: ResidentBoardView(resident: resident)) {
                                ResidentRowView(resident: resident)
                            }
                        }
                        .onDelete { indexSet in
                            if let index = indexSet.first {
                                residentToDelete = filteredResidents[index]
                                showingDeleteAlert = true
                            }
                        }
                    }
                }
            }
            .navigationTitle("Residents")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingSettings = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddResident = true
                    } label: {
                        Image(systemName: "person.badge.plus")
                    }
                }
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
            .sheet(isPresented: $showingAddResident) {
                AddResidentView()
            }
            .alert("Delete Resident", isPresented: $showingDeleteAlert, presenting: residentToDelete) { resident in
                Button("Cancel", role: .cancel) {}
                Button("Delete", role: .destructive) {
                    modelContext.delete(resident)
                }
            } message: { resident in
                Text("This will permanently delete \(resident.name) and all their communication symbols. This action cannot be undone.")
            }
            .searchable(text: $searchText, prompt: "Search by name, room, or unit")
        }
    }
}

import SwiftUI
import SwiftData

struct ResidentListView: View {
    @Query private var residents: [Resident]
    @State private var searchText = ""
    
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
            $0.roomNumber.localizedCaseInsensitiveContains(searchText) || $0.unit.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredResidents) { resident in
                NavigationLink(destination: ResidentBoardView(resident: resident)){
                    ResidentRowView(resident: resident)
                }
            }
            .navigationTitle("Residents")
            .searchable(text: $searchText, prompt: "Search by name, room, or unit")
        }
    }
}

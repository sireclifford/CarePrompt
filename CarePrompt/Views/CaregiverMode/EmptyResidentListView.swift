import SwiftUI

struct EmptyResidentListView: View {
    var body: some View {
        ContentUnavailableView(
            "No Residents",
            systemImage: "person.2.slash",
            description: Text("No residents have been added yet. Resident profiles will appear here once added.")
        )
    }
}

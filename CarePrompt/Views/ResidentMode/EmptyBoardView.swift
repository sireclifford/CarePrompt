import SwiftUI

struct EmptyBoardView: View {
    let residentName: String
    
    var body: some View {
        ContentUnavailableView(
            "No Symbols",
            systemImage: "square.grid.2x2.slash",
            description: Text("\(residentName) doesn't have any communication symbols yet. Symbols can be added from the board editor.")
        )
    }
}

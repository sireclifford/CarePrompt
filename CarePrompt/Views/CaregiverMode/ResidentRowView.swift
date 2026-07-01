import SwiftUI

struct ResidentRowView: View {
    let resident: Resident
    
    var body: some View {
        HStack(spacing: 12) {
            ResidentAvatarView(resident: resident)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(resident.name)
                    .font(.headline)
                HStack(spacing: 6) {
                    Text(resident.unit)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text("·")
                        .foregroundStyle(.secondary)
                    Text("Room \(resident.roomNumber)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()

        }
        .padding(.vertical, 4)
    }
}

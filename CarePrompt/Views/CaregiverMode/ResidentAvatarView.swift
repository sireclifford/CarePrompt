import SwiftUI

struct ResidentAvatarView: View {
    let resident: Resident
    var size: CGFloat = 44

    var body: some View {
        Group {
            if let photoData = resident.photoData,
               let uiImage = UIImage(data: photoData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else {
                ZStack {
                    Color.accentColor.opacity(0.15)
                    Text(String(resident.name.prefix(1)))
                        .font(.system(size: size * 0.4, weight: .semibold))
                        .foregroundStyle(Color.accentColor)
                }
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
    }
}

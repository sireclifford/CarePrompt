import SwiftUI

struct SymbolCardView: View {
    let symbol: Symbol
    let stage: DementiaStage
    
    @State private var isPressed = false
    
    var body: some View {
        Button {
            handleTap()
        }label: {
            VStack(spacing: 12){
                Image(systemName: symbol.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: stage.cardSize * 0.45, height: stage.cardSize * 0.45)
                    .foregroundStyle(Color.accentColor)
                
                if stage.showsTextLabel {
                    Text(symbol.text)
                        .font(.system(size: stage.cardSize * 0.13, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.primary)
                }
            }
            .frame(width: stage.cardSize, height: stage.cardSize)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 2)
            .scaleEffect(isPressed ? 0.94 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.6), value: isPressed)
        }
        .buttonStyle(.plain)
    }
    
    private func handleTap(){
        isPressed = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            isPressed = false
        }
    }
    
}

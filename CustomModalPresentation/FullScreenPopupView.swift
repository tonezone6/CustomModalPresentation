import SwiftUI

struct FullScreenPopupView: View {
    let onDismiss: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text("Full Screen Popup")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("Full screen popup description goes here first line. Second line.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                
                Button("Dismiss") {
                    print("dismissing...")
                    onDismiss()
                }
            }
            .padding()
            .padding(.vertical)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
            )
            .padding()
        }
    }
}

#Preview {
    FullScreenPopupView(onDismiss: {})
}


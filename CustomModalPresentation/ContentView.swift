import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                FirstView()
                    .navigationTitle("First")
            }
            .tabItem { Image(systemName: "1.circle") }
            
            NavigationStack {
                Text("Sceond view")
                    .navigationTitle("Second")
            }
            .tabItem { Image(systemName: "2.circle") }
            
            NavigationStack {
                Text("Third view")
                    .navigationTitle("Third")
            }
            .tabItem { Image(systemName: "3.circle") }
        }
    }
}

struct FirstView: View {
    @State private var isPresented = false

    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<10, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.1))
                        .frame(height: 80)
                        .padding(.horizontal)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Action") {
                    isPresented.toggle()
                }
            }
        }
        .fullscreenModal(
            isPresented: $isPresented,
            presentationStyle: .overFullScreen,
            transitionStyle: .crossDissolve
        ) {
            FullScreenPopupView()
        }
    }
}

#Preview {
    ContentView()
}

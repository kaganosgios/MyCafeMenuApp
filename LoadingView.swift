import SwiftUI
import FirebaseFirestore

struct LoadingView: View {
    @StateObject private var viewModel = CoffeeViewModel()  // CoffeeViewModel
    @State private var isActive = false

    var body: some View {
        ZStack {
            if isActive {
                // Veriler yüklendiyse HomeView'e geçiş
                HomeView(viewModel: viewModel)
            } else {
                // Yüklenme ekranı
                Color(red: 0.9, green: 0.9, blue: 0.9)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Image("cafe1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)

                    Text("Welcome to our Coffee Shop!")
                        .font(.headline)
                }
            }
        }
        .onAppear {
            viewModel.fetchCoffees {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    LoadingView()
}

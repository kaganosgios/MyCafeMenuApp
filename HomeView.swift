import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: CoffeeViewModel  // ViewModel, dışarıdan alınıyor
    @State private var isMenuOpen = false // Menü durumu
    @State private var selectedCategory = "Tümü" // Seçili kategori

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    // Üst Bar
                    HStack {
                        // Menü Butonu
                        Button(action: {
                            withAnimation {
                                isMenuOpen.toggle()
                            }
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .font(.title)
                                .padding()
                        }
                        
                        Spacer()
                        
                        Text("Şefin Önerileri")
                            .font(.largeTitle)
                            .bold()
                        
                        Spacer()
                        
                        // Admin Giriş Butonu
                        NavigationLink(destination: AdminLogInView()) {
                            Image(systemName: "person")
                                .font(.title)
                                .padding()
                        }
                    }
                    .background(Color.white)
                    .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)

                    // Kahve Listesi
                    if viewModel.coffeeList.isEmpty {
                        Text("Loading..")
                    } else {
                        List(filteredCoffees) { coffee in
                            NavigationLink(destination: CoffeeDetailView(coffee: coffee)) {
                                VStack(alignment: .leading) {
                                    Text(coffee.name)
                                        .font(.headline)
                                    Text("$\(coffee.price, specifier: "%.2f")")
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                }

                // Menü Görünümü
                if isMenuOpen {
                                // Yarı saydam arka plan kaplaması
                                Color.black.opacity(0.4)
                                    .edgesIgnoringSafeArea(.all)
                                    .zIndex(1) // Kaplama üstte olacak
                                    .onTapGesture {
                                        withAnimation {
                                            isMenuOpen = false
                                        }
                                    }

                                // Tam ekran menü
                                VStack {
                                    SideMenuView(selectedCategory: $selectedCategory, isMenuOpen: $isMenuOpen)
                                        .background(Color.white)
                                        .edgesIgnoringSafeArea(.all) // Menü tam ekran olacak
                                }
                                .transition(.move(edge: .leading))
                                .zIndex(2) // Menü kaplamanın üstünde olacak
                            }
                        }        }
    }
        
    

    // Kategorilere göre filtrelenmiş kahve listesi
    var filteredCoffees: [Coffee] {
        if selectedCategory == "Tümü" {
            return viewModel.coffeeList
        } else {
            return viewModel.coffeeList.filter { $0.name.contains(selectedCategory) }
        }
    }
}

#Preview {
    HomeView(viewModel: CoffeeViewModel())
}

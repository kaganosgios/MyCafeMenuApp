import SwiftUI

struct SideMenuView: View {
    @Binding var selectedCategory: String
    @Binding var isMenuOpen: Bool
    
    // Örnek kategoriler listesi
    let categories = ["Tümü", "Espresso", "Latte", "Cappuccino", "Macchiato", "Americano"]
    
    var body: some View {
        VStack(alignment: .leading) { // `alignment: .leading` ile sola hizalama
            Button(action: {
                // Menü kapama
                withAnimation {
                    isMenuOpen.toggle()
                }
            }) {
                Text("Kategoriler")
                    .font(.largeTitle)
                    .padding(.bottom, 20)
                    .padding(.leading, 10)
            }
            
            ForEach(categories, id: \.self) { category in
                Button(action: {
                    selectedCategory = category
                    withAnimation {
                        isMenuOpen.toggle()
                    }
                }) {
                    Text(category)
                        .font(.headline)
                        .padding(.vertical, 10)
                        .padding(.leading, 10)  // Sol kenara biraz boşluk
                }
                .frame(maxWidth: .infinity, alignment: .leading) // Tüm genişliği kapla ve sola hizala
            }
            
            Spacer() // Alt kısımda boşluk bırakmak için
        }
        .padding(.top, 40) // Üstten boşluk
        .background(Color.white)
        .frame(maxWidth: .infinity, alignment: .leading) // Sola hizalama için
    }
}

#Preview {
    SideMenuView(selectedCategory: .constant("Tümü"), isMenuOpen: .constant(true))
}

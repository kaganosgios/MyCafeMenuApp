import SwiftUI
import FirebaseFirestore

struct AdminDashboardView: View {
    @StateObject private var viewModel = CoffeeViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Text("Admin View")
                    .font(.largeTitle)
                    .padding()

                List(viewModel.coffeeList) { coffee in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(coffee.name)
                                .font(.headline)
                            Text("$\(coffee.price, specifier: "%.2f")")
                                .font(.subheadline)
                        }
                        Spacer()

                        Button(action: {
                            // Düzenleme işlemi
                        }) {
                            Image(systemName: "pencil")
                                .foregroundColor(.blue)
                        }
                        
                        Button(action: {
                            deleteCoffee(coffee)
                        }) {
                            Image(systemName: "trash")
                        }
                    }
                }

                NavigationLink(destination: AddCoffeeView()) {
                    Text("Add new coffee")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.green)
                        .cornerRadius(10.0)
                        .padding(.horizontal)
                }
            }
        }
        .onAppear {
            viewModel.fetchCoffees {
                // Veriler çekildikten sonra yapılacak işlemler
                print("Coffees loaded successfully")
            }
        }
    }

    private func deleteCoffee(_ coffee: Coffee) {
        viewModel.deleteCoffee(coffee: coffee)
    }
}


#Preview {
    AdminDashboardView()
}
                            

//
//  AddCoffeeView.swift
//  CafeApp
//
//  Created by KağanKAPLAN on 21.11.2024.
//

import SwiftUI
import FirebaseFirestore

struct AddCoffeeView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var price = ""
    @State private var description = ""
    @State private var imageUrl = ""
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Coffe Informations")){
                    TextField("Coffee Name:", text: $name)
                    TextField("Price", text: $price)
                    TextField("Description", text: $description)
                    TextField("Image Url", text: $imageUrl)
                }
                Button(action: addCoffee) {
                    Text("Add coffee")
                        .padding()
                        .frame(maxWidth:.infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10.0)
                }
            }
        }.navigationTitle("Add Coffee")
        
        
    }
    private func addCoffee() {
        let db = Firestore.firestore()
        let newCoffee = [
            "name": name,
            "price": Double(price) ?? 0.0,
            "description": description,
            "imageUrl": imageUrl
        ] as [String : Any]
        
        db.collection("coffeeSuggestions").addDocument(data: newCoffee) { error in
            if let error = error {
                print("Error adding coffee: \(error.localizedDescription)")
            } else {
                // Veri ekleme işlemi başarılı olduğunda, verileri yeniden yükleyin
                print("Coffee added successfully!")
                // Burada viewModel'in fetchCoffees fonksiyonunu çağırarak güncel veriyi çekebilirsiniz
                // Örnek: viewModel.fetchCoffees { }
                presentationMode.wrappedValue.dismiss()
            }
        }
    }

    
}

#Preview {
    AddCoffeeView()
}

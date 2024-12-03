//
//  CoffeeDetailView.swift
//  CafeApp
//
//  Created by KağanKAPLAN on 16.11.2024.
//

import SwiftUI

struct CoffeeDetailView: View {
    var coffee: Coffee
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading){
                    if let url = URL(string: coffee.imageUrl){
                        AsyncImage(url: url){ image in
                            image
                                .resizable().scaledToFit()
                            
                        } placeholder: {
                            Color.gray.opacity(3.00)
                        }
                        .frame(height:200)
                        .cornerRadius(10.00)
                    }
                    Text(coffee.name)
                     .font(.largeTitle)
                     .bold()
                     .padding(.top)

                 Text("₺\(coffee.price, specifier: "%.2f")")
                     .font(.title)
                     .foregroundColor(.secondary)

                 Text(coffee.description)
                     .font(.body)
                     .padding(.top)
               
                }
                .padding()
            }
            .navigationTitle(coffee.name)
            navigationBarTitleDisplayMode(.inline)
        }
       
    }
}

#Preview {
    CoffeeDetailView(coffee: Coffee(id: "1", name: "kahve", price: 12.00, imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d8/Caffe_Latte_at_Pulse_Cafe.jpg/800px-Caffe_Latte_at_Pulse_Cafe.jpg", description: "Kahve cok hostur"))
}

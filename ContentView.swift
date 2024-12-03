//
//  ContentView.swift
//  CafeApp
//
//  Created by KağanKAPLAN on 13.11.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView(viewModel: CoffeeViewModel())  
    }
}
#Preview {
    ContentView()
}

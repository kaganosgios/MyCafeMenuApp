//
//  CafeAppApp.swift
//  CafeApp
//
//  Created by KağanKAPLAN on 13.11.2024.
//

import SwiftUI
import Firebase

@main
struct CafeAppApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoadingView()
        }
    }
}

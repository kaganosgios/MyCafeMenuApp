//
//  AdminLogInView.swift
//  CafeApp
//
//  Created by KağanKAPLAN on 19.11.2024.
//

import SwiftUI
import FirebaseAuth

struct AdminLogInView: View {
    @State  private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = true
    
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var isLoggedInn = false
    
    var body: some View {
        if isLoggedInn{
            AdminDashboardView()
        }else{
            NavigationView{
                VStack(spacing: 16){
                    Picker("Login Mode", selection: $isLoggedIn){
                        Text("Log In").tag(true)
                        Text("Sign Up").tag(false)
                        
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10.0)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10.0)
                    
                    Button (action: handleAction){
                        Text(isLoggedIn ? "Log In" : "Sign Up")
                            .padding()
                            .frame(width: 190, height: 35)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        
                    }
                    if(showError){
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                }
                
            }
            .padding()
            .navigationTitle(isLoggedIn ? "Admin Girişi" : "Admin Kaydı")
        }
        
    }
    private func handleAction(){
        
        if isLoggedIn {
            loginUser()
        }else{
            registerUser()
        }
        
    }
    private func loginUser(){
        Auth.auth().signIn(withEmail: email, password: password){ result, error in
            if let error = error {
                self.errorMessage = "Login Error: \(error.localizedDescription)"
                self.showError = true
                    return
            }
            withAnimation {
                            self.isLoggedInn = true
                        }        }
        
    }
    private func registerUser(){
        Auth.auth().createUser(withEmail: email, password: password){result,error in
            if let error=error{
                self.errorMessage = "Sign Up Error: \(error.localizedDescription)"
                self.showError = true
                return
            }
            print("Sign Up Success: \(result?.user.email ?? "")")
        }
        
    }

}


#Preview {
    AdminLogInView()
}

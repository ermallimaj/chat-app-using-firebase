//
//  ContentView.swift
//  Chat-App-Firebase-Swift
//
//  Created by Ermal Limaj on 2/25/24.
//

import SwiftUI

struct LoginView: View {
    
    @State private var isLoginMode = false
    
    @State private var email = ""
    
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                VStack(spacing: 16) {
                    Picker(selection: $isLoginMode, label: Text("Picker here")) {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                        
                    if !isLoginMode {
                        Button(action: {
                            // Action for creating account
                        }) {
                            Image(systemName: "person.fill")
                                .font(.system(size: 64))
                                .padding()
                        }
                    }
                    
                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        SecureField("Password", text: $password)
                            .autocapitalization(.none)
                    }
                    .padding(12)
                    .background(Color.white)
                    
                    Button(action: {
                        handleAction()
                    }) {
                        HStack {
                            Spacer()
                            Text(isLoginMode ? "Log In" : "Create Account")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        }.background(Color.blue)
                        
                    }
                }
                .padding()
                
            }
            .navigationTitle(isLoginMode ? "Log In" : "Create Account")
            .background(Color(.init(white: 0, alpha: 0.05))
                            .ignoresSafeArea())
        }
    }
    
    private func handleAction() {
        if isLoginMode {
            print("Should log in with existing credentials!")
        } else {
            print("Register a new account!")
        }
    }
}

struct ContentView_Previews1: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

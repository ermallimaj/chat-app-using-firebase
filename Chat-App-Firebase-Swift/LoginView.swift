//
//  ContentView.swift
//  Chat-App-Firebase-Swift
//
//  Created by Ermal Limaj on 2/25/24.
//
// Gentrit test commit
import SwiftUI
import Firebase

class FirebaseManager: NSObject {
    
    let auth: Auth
    
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        
        super.init()
    }
    
}

struct LoginView: View {
    
    @State private var isLoginMode = false

    @State private var email = ""

    @State private var password = ""

    @State private var firstname = ""

    @State private var lastname = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    Picker(selection: $isLoginMode, label: Text("Picker here")) {
                        Text("Login").tag(true)
                        Text("Create Account").tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    if !isLoginMode {
                        Button(action: {}) {
                            Image(systemName: "person.fill")
                                .foregroundColor(.black)
                                .font(.system(size: 64))
                                .padding()
                        }
                        Group {
                            TextField("First name", text: $firstname)
                            TextField("Last name", text: $lastname)
                        }
                        .padding(12)
                        .background(Color.white)
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
                        }.background(isLoginMode ? Color.blue : Color.green)
                        
                    }
                    
                    Text(self.loginStatusMessage)
                        .foregroundColor(.red)
                }
                .padding()
                
            }
            .navigationTitle(isLoginMode ? "Log In" : "Create Account")
            .background(Color(.init(white: 0, alpha: 0.05))
                            .ignoresSafeArea())
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func handleAction() {
        if isLoginMode {
            loginUser()
        } else {
            createNewAccount()
        }
    }
    
    private func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to login user:", err)
                self.loginStatusMessage = "Failed to login user, should login using existing credentials"
                return
            }
            
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
            
            self.loginStatusMessage = "Successfully logged in!"
        }
    }
    
    @State private var loginStatusMessage = ""
    
    private func createNewAccount() {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to create user:", err)
                self.loginStatusMessage = "Failed to create user!"
                return
            }
            // will be saved later to the database along with the email and password
            let userData = ["firstname": firstname, "lastname": lastname]
            
            print("Successfully created user: \(result?.user.uid ?? "")")
            
            self.loginStatusMessage = "Successfully created user!"
        }
    }
}

struct Previews_LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

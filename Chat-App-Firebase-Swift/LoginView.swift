//
//  ContentView.swift
//  Chat-App-Firebase-Swift
//
//  Created by Ermal Limaj on 2/25/24.
//
// Gentrit test commit
import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore


struct LoginView: View {
    
    @State private var isLoginMode = false

    @State private var email = ""

    @State private var password = ""

    @State private var firstname = ""

    @State private var lastname = ""
    
    @State private var showImage = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    Picker(selection: $isLoginMode, label: Text("Picker here")) {
                        Text("Login").tag(true)
                        Text("Create Account").tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    if !isLoginMode {
                        Button {
                            showImage.toggle()
                        } label: {
                            
                            
                            VStack {
                                if let image = self.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 128, height: 128)
                                        .cornerRadius(64)
                                } else {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 64))
                                        .padding()
                                        .foregroundColor(Color(.black))
                                }
                            }
                            .overlay(RoundedRectangle(cornerRadius: 64)
                                        .stroke(Color.black, lineWidth: 3)
                                     )
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
                           .fullScreenCover(isPresented: $showImage, onDismiss: nil) {
                               ImagePicker(image: $image)
                           }
                       }
                       
                       @State var image: UIImage?
                       
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
                                   self.loginStatusMessage = "Failed to login user: \(err)"
                                   return
                               }
                               
                               print("Successfully logged in as user: \(result?.user.uid ?? "")")
                               
                               self.loginStatusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
                           }
                       }
                       
                       @State var loginStatusMessage = ""
                       
                       private func createNewAccount() {
                           FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, err in
                               if let err = err {
                                   print("Failed to create user:", err)
                                   self.loginStatusMessage = "Failed to create user: \(err)"
                                   return
                               }
                               
                               print("Successfully created user: \(result?.user.uid ?? "")")
                               
                               self.loginStatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
                               
                               self.persistImageToStorage()
                           }
                       }
                       
                       private func persistImageToStorage() {
                           guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
                           let ref = FirebaseManager.shared.storage.reference(withPath: uid)
                           guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else { return }
                           ref.putData(imageData, metadata: nil) { metadata, err in
                               if let err = err {
                                   self.loginStatusMessage = "Failed to push image to Storage: \(err)"
                                   return
                               }
                               
                               ref.downloadURL { url, err in
                                   if let err = err {
                                       self.loginStatusMessage = "Failed to retrieve downloadURL: \(err)"
                                       return
                                   }
                                   
                                   self.loginStatusMessage = "Successfully stored image with url: \(url?.absoluteString ?? "")"
                                   print(url?.absoluteString)
                                   
                                   guard let url = url else { return }
                                   
                                   self.storeUserData(profilePicUrl: url)
                               }
                           }
                       }
    private func storeUserData(profilePicUrl: URL) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let userData = [ "uid": uid, "firsNname": self.firstname,"lastName": self.lastname,"email": self.email, "profileImageUrl": profilePicUrl.absoluteString]
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    self.loginStatusMessage = "\(err)"
                    return
                }
                
                print("Success")
            }
    }
                   }

struct Previews_LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

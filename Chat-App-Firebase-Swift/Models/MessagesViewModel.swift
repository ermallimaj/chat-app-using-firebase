//
//  MessagesViewModel.swift
//  Chat-App-Firebase-Swift
//
//  Created by Ermal Limaj on 2/27/24.
//

import Foundation

class MainMessagesViewModel: ObservableObject {
    
    @Published var errorMessage = ""
    @Published var chatUser: ChatUser?
    
    init() {
        fetchCurrentUser()
    }
    
    private func fetchCurrentUser() {
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return
        }
        
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current user: \(error)"
                print("Failed to fetch current user:", error)
                return
            }
            
            
            guard let data = snapshot?.data() else {
                self.errorMessage = "No data found"
                return
                
            }
            let uid = data["uid"] as? String ?? ""

            let firstname = data["firsNname"] as? String ?? ""

            let lastname = data["lastName"] as? String ?? ""

            let email = data["email"] as? String ?? ""

            let profileImageUrl = data["profileImageUrl"] as? String ?? ""

            self.chatUser = ChatUser(uid: uid, firstname: firstname, lastname: lastname, email: email, profileImageUrl: profileImageUrl)
        }
    }
    
}

//
//  ChatViewModel.swift
//  Chat-App-Firebase-Swift
//
//  Created by Ermal Limaj on 2/28/24.
//

import Foundation
import Firebase
import SwiftUI

class ChatViewModel: ObservableObject {
    
    @Published var chatMessage = ""
    
    @Published var errMessage = ""
    
    @Published var chatMessages = [ChatMessage]()

    let chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        
        fetchMessages()
    }
    
    func fetchMessages() {
            guard let fromUid = FirebaseManager.shared.auth.currentUser?.uid else { return }
            guard let toUid = chatUser?.uid else { return }
            FirebaseManager.shared.firestore
                .collection("messages")
                .document(fromUid)
                .collection(toUid)
                .order(by: "time")
                .addSnapshotListener { querySnapshot, err in
                    if let err = err {
                        self.errMessage = "Failed to listen for messages: \(err)"
                        print(err)
                        return
                    }
                    
                    querySnapshot?.documentChanges.forEach({ change in
                        if change.type == .added {
                            print("Message was fetched successfully")
                            let data = change.document.data() 
                            self.chatMessages.append(.init(docId: change.document.documentID, data: data))
                        }
                    })
                }
        }
    
    func sendMessage(){
        print(chatMessage)
        
        guard let fromUid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        guard let toUid = chatUser?.uid else { return }
        
        let sendMessage = FirebaseManager.shared.firestore.collection("messages")
            .document(fromUid)
            .collection(toUid)
            .document()
        
        let messageData = [FirebaseConstants.fromUid: fromUid, FirebaseConstants.toUid: toUid, FirebaseConstants.message: self.chatMessage, "time": Timestamp()] as [String : Any]
        
        sendMessage.setData(messageData) { err in
            if let err = err {
                print(err)
                self.errMessage = "Failed to save the message into Firestore: \(err)"
            }
            print("Successfully sent the sender's message")
            self.chatMessage = ""
        }
        
        
        
        let receiveMessage = FirebaseManager.shared.firestore.collection("messages")
            .document(toUid)
            .collection(fromUid)
            .document()
        
        receiveMessage.setData(messageData) { err in
            if let err = err {
                print(err)
                self.errMessage = "Failed to save the message into Firestore: \(err)"
            }
            print("Successfully received the user's message")

        }

    }
}
	

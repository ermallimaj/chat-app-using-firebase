//
//  ChatViewModel.swift
//  Chat-App-Firebase-Swift
//
//  Created by Ermal Limaj on 2/28/24.
//

import Foundation
import Firebase

class ChatViewModel: ObservableObject {
    
    @Published var chatMessage = ""
    
    @Published var errMessage = ""
    
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
    }
    
    func sendMessage(){
        print(chatMessage)
        
        guard let fromUid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        guard let toUid = chatUser?.uid else {
            return
        }
        
        let sendMessage = FirebaseManager.shared.firestore.collection("messages")
            .document(fromUid)
            .collection(toUid)
            .document()
        
        let messageRcv = ["fromUid": fromUid, "toUid": toUid, "message": self.chatMessage, "time": Timestamp()] as [String : Any]
        
        sendMessage.setData(messageRcv) { err in
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
        
        receiveMessage.setData(messageRcv) { err in
            if let err = err {
                print(err)
                self.errMessage = "Failed to save the message into Firestore: \(err)"
            }
            print("Successfully received the user's message")

        }

    }
}

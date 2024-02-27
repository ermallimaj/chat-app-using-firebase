//
//  ChatUser.swift
//  Chat-App-Firebase-Swift
//
//  Created by Ermal Limaj on 2/27/24.
//

import Foundation

struct ChatUser {
    let uid, firstname, lastname, email, profileImageUrl: String
    
    init(data: [String:Any]){
        self.uid = data["uid"] as? String ?? ""

        self.firstname = data["firsNname"] as? String ?? ""

        self.lastname = data["lastName"] as? String ?? ""

        self.email = data["email"] as? String ?? ""

        self.profileImageUrl = data["profileImageUrl"] as? String ?? ""
    }
}

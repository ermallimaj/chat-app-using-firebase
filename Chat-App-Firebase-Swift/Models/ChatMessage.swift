//
//  ChatMessage.swift
//  Chat-App-Firebase-Swift
//
//  Created by Ermal Limaj on 2/28/24.
//

import Foundation
import Firebase
import SwiftUI

struct ChatMessage: Identifiable {
    
    var id: String { docId }
    
    let docId: String
    
    let fromUid, toUid, message: String
    
    init(docId: String, data: [String: Any]) {
        self.docId = docId
        self.fromUid = data[FirebaseConstants.fromUid] as? String ?? ""
        self.toUid = data[FirebaseConstants.toUid] as? String ?? ""
        self.message = data[FirebaseConstants.message] as? String ?? ""
    }
}

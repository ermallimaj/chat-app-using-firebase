//
//  NewMessageView.swift
//  Chat-App-Firebase-Swift
//
//  Created by Ermal Limaj on 2/27/24.
//

import SwiftUI
import SDWebImageSwiftUI


struct NewMessageView: View {
    
    let userSelectedNewChat: (ChatUser) -> ()
    
    @Environment(\.presentationMode) var presentationMode
        	
        @ObservedObject var vm = NewMessageViewModel()
        
        var body: some View {
            NavigationView {
                ScrollView {
                    Text(vm.errorMessage)
                    
                    ForEach(vm.users) { user in
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            userSelectedNewChat(user)
                        } label: {
                            HStack(spacing: 16) {
                                WebImage(url: URL(string: user.profileImageUrl))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipped()
                                    .cornerRadius(50)
                                    .overlay(RoundedRectangle(cornerRadius: 50)
                                                .stroke(Color(.label), lineWidth: 2)
                                    )
                                VStack{
                                    Text(user.firstname + " " + user.lastname)
                                    Text(user.email)
                                        .foregroundColor(Color(.label))
                                }
                                 Spacer()
                            }.padding(.horizontal)
                        }
                        Divider()
                            .padding(.vertical, 8)
                        
                        
                    }
                }.navigationTitle("New Message")
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarLeading) {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text("Cancel")
                    }
                }
            }
        }
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}

//
//  ChatView.swift
//  Chat-App-Firebase-Swift
//
//  Created by Ermal Limaj on 2/27/24.
//

import SwiftUI

struct ChatView: View {
    
    let chatUser: ChatUser?
        
    init (chatUser: ChatUser?) {
        self.chatUser = chatUser
        self.vm = .init(chatUser: chatUser)
    }
    
    @ObservedObject var vm: ChatViewModel
    
    var body: some View {
        ZStack{
            messages
            Text(vm.errMessage)
        }
            ZStack {
                
                VStack(spacing: 0) {
                    Spacer()
                        .background(Color.white.ignoresSafeArea())
                }
            }
        
        .navigationTitle((chatUser?.firstname ?? "") + " " + (chatUser?.lastname ?? ""))
            .navigationBarTitleDisplayMode(.inline)

    }
    private var messages: some View {
        VStack{
            if #available (iOS 15.0, *) {
                ScrollView {
                    ForEach(0..<20) { num in
                        HStack {
                            Spacer()
                            HStack {
                                Text("Fake text")
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                    }
                    
                    HStack{ Spacer() }
                    .frame(height: 50)
                }
                .background(Color(.init(white: 0.95, alpha: 1)))
                .safeAreaInset(edge: .bottom) {
                    chatBar
                        .background(Color(.systemBackground).ignoresSafeArea())
                }
                            
            } else {
                
            }
                
        }
        
    }
        
        private var chatBar: some View {
            HStack(spacing: 16) {
                Image(systemName: "photo")
                    .font(.system(size: 24))
                    .foregroundColor(Color(.darkGray))
                ZStack {
                    MessagePlaceholder()
                    TextEditor(text: $vm.chatMessage)
                        .opacity(vm.chatMessage.isEmpty ? 0.5 : 1)
                }
                .frame(height: 40)
                
                Button {
                    vm.sendMessage()
                } label: {
                    Text("Send")
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color.blue)
                .cornerRadius(4)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
    }
    private struct MessagePlaceholder: View {
        var body: some View {
            HStack {
                Text("Write here...")
                    .foregroundColor(Color(.gray))
                    .font(.system(size: 17))
                    .padding(.leading, 5)
                    .padding(.top, -4)
                Spacer()
            }
        }
    }

struct ChatView_Previews1: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ChatView(chatUser: .init(data: ["uid":"6otfDI6g4lPNlzjlboTyseOP2y92","firsNname":"Ermal", "lastName": "Limaj"]))
        }
    }
}

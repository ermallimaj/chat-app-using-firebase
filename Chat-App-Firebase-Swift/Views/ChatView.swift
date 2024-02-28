//
//  ChatView.swift
//  Chat-App-Firebase-Swift
//
//  Created by Ermal Limaj on 2/27/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore
		
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
        .navigationTitle((chatUser?.firstname ?? "") + " " + (chatUser?.lastname ?? ""))
            .navigationBarTitleDisplayMode(.inline)

    }
    
    static let emptyScrollToString = "Empty"

    
    private var messages: some View {
        VStack {
            if #available(iOS 15.0, *) {
                ScrollView {
                    ScrollViewReader { scrollViewProxy in
                        VStack {
                            ForEach(vm.chatMessages) { message in
                                MessageView(message: message)
                            }
                            
                            HStack{ Spacer() }
                            .id(Self.emptyScrollToString)
                        }
                        .onReceive(vm.$count) { _ in
                            withAnimation(.easeOut(duration: 0.5)) {
                                scrollViewProxy.scrollTo(Self.emptyScrollToString, anchor: .bottom)
                            }
                            
                        }
                        
                        
                        
                    }
                    
                }
                .background(Color(.init(white: 0.95, alpha: 1)))
                .safeAreaInset(edge: .bottom) {
                    chatBar
                        .background(Color(.systemBackground).ignoresSafeArea())
                }
            } else {
                    Text("Your iOS device is not supported, earliest version supported: iOS 15.0")
                }
            }
        }
    struct MessageView: View {
        
        let message: ChatMessage
        
        var body: some View {
            VStack {
                if message.fromUid == FirebaseManager.shared.auth.currentUser?.uid {
                    HStack {
                        Spacer()
                        HStack {
                            Text(message.message)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                    }
                } else {
                    HStack {
                        HStack {
                            Text(message.message)
                                .foregroundColor(.black)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        Spacer()
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 8)
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
                .padding(.vertical, 10)
                .background(Color.blue)
                .cornerRadius(5)
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
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
        MessagesView()
    }
}

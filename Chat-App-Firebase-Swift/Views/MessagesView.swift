//
//  MessagesView.swift
//  Chat-App-Firebase-Swift
//
//  Created by Ermal Limaj on 2/27/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct MessagesView: View {
    
    @State var showLogOLut = false
    
    @State var navToChatView = false
    
    @ObservedObject private var vm = MainMessagesViewModel()
    
    var body: some View {
        NavigationView {
            
            VStack {
                customNavBar
                messagesView
                
                NavigationLink("", isActive: $navToChatView) {
                    ChatView(chatUser: self.chatUser)
                }
            }
            .overlay(
                newMessageButton, alignment: .bottom)
            .navigationBarHidden(true)
        }
    }
    
    private var customNavBar: some View {
        HStack(spacing: 16) {
            
            WebImage(url: URL(string: vm.chatUser?.profileImageUrl ?? ""))
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipped()
                .cornerRadius(50)
                .overlay(RoundedRectangle(cornerRadius: 44)
                            .stroke(Color(.label), lineWidth: 1)
                )
                .shadow(radius: 5)
            
            
            VStack(alignment: .leading, spacing: 4) {
                let firstname = vm.chatUser?.firstname ?? ""
                
                let lastname = vm.chatUser?.lastname ?? ""
                
                let fullName = firstname + " " + lastname
                
                Text(fullName)
                    .font(.system(size: 24, weight: .bold))
                
                HStack {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 14, height: 14)
                    Text("Online")
                        .font(.system(size: 13))
                        .foregroundColor(Color(.lightGray))
                }
                
            }
            
            Spacer()
            Button {
                showLogOLut.toggle()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(.label))
            }
        }
        .padding()
        .actionSheet(isPresented: $showLogOLut) {
            .init(title: Text("Settings"), message: Text("What's your decision?"), buttons: [
                .destructive(Text("Sign Out"), action: {
                    vm.signOut()
                }),
                    .cancel()
            ])
        }
        .fullScreenCover(isPresented: $vm.isUserLoggedOut, onDismiss: nil) {
            LoginView(loginSuccess:{
                self.vm.isUserLoggedOut = false
                self.vm.fetchCurrentUser()
            })
        }
    }
    
    private var messagesView: some View {
        ScrollView {
            ForEach(0..<10, id: \.self) { num in
                VStack {
                    NavigationLink {
                        Text("Destination")
                    } label: {
                        HStack(spacing: 16) {
                            Image(systemName: "person.fill")
                                .font(.system(size: 32))
                                .padding(8)
                                .overlay(RoundedRectangle(cornerRadius: 44)
                                            .stroke(Color(.label), lineWidth: 1)
                                )
                            
                            
                            VStack(alignment: .leading) {
                                Text("Username")
                                    .font(.system(size: 16, weight: .bold))
                                Text("Message sent to user")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(.gray))
                            }
                    }
                        Spacer()
                        
                        Text("22d")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    Divider()
                        .padding(.vertical, 8)
                }.padding(.horizontal)
                
            }.padding(.bottom, 50)
        }
    }
    
    @State var showNewMessageScreen = false
    
    private var newMessageButton: some View {
        Button {
            showNewMessageScreen.toggle()
        } label: {
            HStack {
                Spacer()
                Text("New Message")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.vertical)
                .background(Color.green)
                .cornerRadius(32)
                .padding(.horizontal)
                .shadow(radius: 15)
        }
        .fullScreenCover(isPresented: $showNewMessageScreen){
            NewMessageView (userSelectedNewChat: {ChatUser in
                print("User chose to chat with: " + ChatUser.firstname + " " + ChatUser.lastname)
                self.navToChatView.toggle()
                self.chatUser = ChatUser
            })
        }
    }
    @State var chatUser: ChatUser?
}

struct MessagesView_Previews1: PreviewProvider {
    static var previews: some View {
        MessagesView()
            .preferredColorScheme(.light)
    }
}

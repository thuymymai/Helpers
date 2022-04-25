//
//  HelpSeekersProfile.swift
//  Helper
//
//  Created by Annie Huynh on 12.4.2022.
//

import SwiftUI

struct Profile: View {
    @State private var pushNoti = true
    
    var body: some View {
//        NavigationView {
            ZStack{
                Color("Background").edgesIgnoringSafeArea(.top)
                VStack{
                    ZStack{
                        Image("BG Mask").edgesIgnoringSafeArea(.all)
                        VStack{
                            Image("Avatar-1")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .shadow(color: .black, radius: 3)
                            
                            Label("Profile", systemImage: "person")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                    }
                    List {
                        Section(header: Text("Account Settings")) {
                            SettingsView(name: "Update Basic Information")
                            SettingsView(name: "Update Medical Information")
                            NavigationLink(destination: TaskList()) {
                                SettingsView(name:"Your Tasks")
                            }
                            SettingsView(name:"Change Passwords")
                        }.font(.system(size: 16))
                        Section(header: Text("Preferences")) {
                            Toggle("Push Notification", isOn: $pushNoti)
                                .font(.headline)
                                .foregroundColor(Color.black.opacity(0.6))
                                .padding()
                            SettingsView(name:"Change language")
                        }.font(.system(size: 16))
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
//        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}

struct SettingsView: View {
    var name: String
    var body: some View {
        Button(action: {
        
        }){
            HStack {
                Text(name)
                Spacer(minLength: 15)
            }.padding()
                .font(.headline)
                .foregroundColor(Color.black.opacity(0.6))
        }
    }
}


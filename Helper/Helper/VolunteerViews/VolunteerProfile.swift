//
//  VolunteerProfile.swift
//  Helper
//
//  Created by Annie Huynh on 5.4.2022.
//

import SwiftUI

struct VolunteerProfile: View {
    @State private var pushNoti = true
    
    var body: some View {
        NavigationView {
            ZStack{
                Color("Background").edgesIgnoringSafeArea(.all)
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
                            
                            SettingsView(name: "Edit Profile")
                            SettingsView(name:"Change Passwords")
                            NavigationLink(destination: TaskList()) {
                                SettingsView(name:"Task History")
                            }
                            
                        }.font(.system(size: 16))
                        Section(header: Text("Preferences")) {
                            Toggle("Push Notification", isOn: $pushNoti)
                                .font(.headline)
                                .foregroundColor(Color.black.opacity(0.6))
                                .padding()
                            SettingsView(name:"Change language")
                            SettingsView(name: "Update availability")
                        }.font(.system(size: 16))
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct VolunteerProfile_Previews: PreviewProvider {
    static var previews: some View {
        VolunteerProfile()
    }
}


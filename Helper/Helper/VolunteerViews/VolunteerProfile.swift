//
//  VolunteerProfile.swift
//  Helper
//
//  Created by Annie Huynh on 5.4.2022.
//

import SwiftUI

struct VolunteerProfile: View {
    @State private var pushNoti = true
    @State private var showingSheet = false

    @Binding var volunteerName: String
    var body: some View {
        NavigationView {
            ZStack{
                Color("Background").edgesIgnoringSafeArea(.top)
                VStack{
                    ZStack{
                        Image("BG Mask").edgesIgnoringSafeArea(.all)
                        VStack{
                            Image("volunteer")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .shadow(color: .black, radius: 3)
                                
                            
                            Text("\(volunteerName)")
                                .font(.title)
                                .foregroundColor(.white)
                        }.offset(y: -20)
                    }
                    List {
                        Section(header: Text("Account Settings")) {
                            SettingsView(name: "Edit Profile")
                               
                            SettingsView(name:"Change Passwords")
                            NavigationLink(destination: LandingPage()) {
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
                }.padding(.top, -30)
                    .padding(.bottom,5)
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct VolunteerProfile_Previews: PreviewProvider {
    static var previews: some View {
        VolunteerProfile(volunteerName: .constant(""))
    }
}


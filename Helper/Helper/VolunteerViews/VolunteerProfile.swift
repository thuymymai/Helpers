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
        ScrollView{
            ZStack{
                Color("Background").edgesIgnoringSafeArea(.all)
                VStack(spacing:35){
                    ZStack{
                        Image("BG Mask").edgesIgnoringSafeArea(.all)
                        VStack{
                            Image("Avatar-1")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .shadow(color: .black, radius: 3)
                            Label("Settings", systemImage: "gearshape")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.leading,-170)
                            
                        }
                    }
                    GeometryReader { geometry in
                        VStack(alignment:.leading){
                            List{
                                Section(header: Text("Account")
                                ) {
                                    SettingsView(name: "Edit Profile")
                                    SettingsView(name:"Change Passwords")
                                    SettingsView(name:"Task History")
                                }.font(.system(size: 16))
                                Section(header: Text("Preferences")) {
                                    Toggle("Push Notification", isOn: $pushNoti)
                                        .font(.headline)
                                        .foregroundColor(Color.black.opacity(0.6))
                                        .padding()
                                    SettingsView(name:"Change language")
                                    SettingsView(name:"Update availability")
                                }.font(.system(size: 16))
                            }.padding(.bottom,50)
                                .background(.white)
                                .frame( height: geometry.size.height * 60, alignment: .center)
                        }
                    }
                    
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct VolunteerProfile_Previews: PreviewProvider {
    static var previews: some View {
        VolunteerProfile()
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
                Image(systemName: "chevron.right")
            }.padding()
                .font(.headline)
                .foregroundColor(Color.black.opacity(0.6))
            
        }
    }
}


//
//  HelpSeekersProfile.swift
//  Helper
//
//  Created by Annie Huynh on 12.4.2022.
//

import SwiftUI

struct Profile: View {
    @State private var pushNoti = true
    @Binding var helpseekerName: String
    
    var body: some View {
        ZStack{
            Color("Background").edgesIgnoringSafeArea(.top)
            VStack{
                ZStack{
                    Image("BG Mask").edgesIgnoringSafeArea(.all)
                    VStack{
                        Image("avatar")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .shadow(color: .black, radius: 3)
                        Text(helpseekerName)
                            .font(.title)
                            .foregroundColor(.white)
                    }.padding(.top,-70)
                }
                List {
                    Section(header: Text("Account Settings")) {
                        SettingsView(name: "Update Basic Information")
                        SettingsView(name:"Update Medical Informations")
                        NavigationLink(destination: TaskList(helpseekerName: $helpseekerName)) {
                            SettingsView(name:"Your Tasks")
                        }
                    }.font(.system(size: 16))
                    Section(header: Text("Preferences")) {
                        NavigationLink(destination: LandingPage().navigationBarHidden(true)) {
                            SettingsView(name:"Log Out")
                        }
                        Toggle("Push Notification", isOn: $pushNoti)
                            .font(.headline)
                            .foregroundColor(Color.black.opacity(0.6))
                            .padding()
                        //SettingsView(name:"Change language")
                        
                    }.font(.system(size: 16))
                }.padding(.top,-60)
            }.padding(.top, -30)
                .padding(.bottom,5)
        }
    }
}



struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile(helpseekerName: .constant(""))
    }
}

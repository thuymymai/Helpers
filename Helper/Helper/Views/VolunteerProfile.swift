//
//  VolunteerProfile.swift
//  Helper
//
//  Created by Annie Huynh on 5.4.2022.
//

import SwiftUI

struct VolunteerProfile: View {
    var body: some View {
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
                        
                        Label("Settings", systemImage: "gearshape")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.leading,-170)
                            
                    }.padding(.top,-50)
                    
                }
                List {
                    Section(header: Text("Account")) {

                        SettingsView(name: "Edit Profile")
                        SettingsView(name:"Change Passwords")
                        SettingsView(name:"Task History")


                    }.font(.system(size: 16))
                    Section(header: Text("Preference")) {
                        SettingsView(name:"Change language")
                        SettingsView(name:"Update availability")
                    }.font(.system(size: 16))

                }
                
            }
            
            
        }
        
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
                //                Label("Length", systemImage: "clock")
                Text(name)
                Spacer(minLength: 15)
                Image(systemName: "chevron.right")
            }.padding()
                .font(.headline)
                .foregroundColor(Color.black.opacity(0.6))
            
        }
    }
}


//
//  VolunteerProfile.swift
//  Helper
//
//  Created by Annie Huynh on 5.4.2022.
//

import SwiftUI

struct VolunteerProfile: View {
    @State var pushNoti = true
    @State private var showingSheet = false
    
    @Binding var volunteerName: String
    
    var body: some View {
        NavigationView {
            ZStack{
                Color("Background")
                VStack{
                    ZStack{
                        Image("BG Mask")
                        VStack{
                            Image("volunteer")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .shadow(color: .black, radius: 3)
                            Text("\(volunteerName)")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .offset(y: -20)
                    }
                    List {
                        Section(header: Text("Account Settings")) {
                            if (Locale.preferredLanguages[0] == "fi") {
                                SettingsView(name: "Muokkaa profiilia")
                                SettingsView(name:"Vaihda salasanat")
                            } else {
                                SettingsView(name: "Edit Profile")
                                SettingsView(name:"Change Passwords")
                            }
                        }
                        .font(.system(size: 16))
                        
                        Section(header: Text("Preferences")) {
                            Toggle("Push Notification", isOn: $pushNoti)
                                .font(.headline)
                                .foregroundColor(Color.black.opacity(0.6))
                                .padding()
                            if (Locale.preferredLanguages[0] == "fi") {
                                SettingsView(name: "Päivitä saatavuus")
                            } else {
                                SettingsView(name: "Update availability")
                            }
                        }
                        .font(.system(size: 16))
                    }
                }
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
            .preferredColorScheme(.dark)
    }
}


//
//  VolunteersNavBar.swift
//  Helper
//
//  Created by Annie Huynh on 18.4.2022.
//

import SwiftUI

enum Tabs: String {
    case Dashboard
    case Location
    case Tasks
    case Profile
}

struct VolunteersNavBar: View {
    
    @Binding var volunteerName: String
    
    @State var selectedTab: Tabs = .Dashboard
    
    @State private var isLogoutMenuClicked = false
    @State private var isFirstAidClicked = false
    @State private var isLinkActive: Bool = false
    
    @ViewBuilder
    func chooseDestination()-> some View {
      if (isLogoutMenuClicked){
            LandingPage().navigationBarHidden(true)
        }else {
            EmptyView()
        }
    }
    var body: some View {
        NavigationView{
            TabView(selection: $selectedTab){
                VolunteerDashboard( volunteerName: $volunteerName)
                    .tabItem(){
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(Tabs.Dashboard)
                Location()
                    .tabItem(){
                        Image(systemName: "map")
                        Text("Location")
                    }
                    .tag(Tabs.Location)
//                EditProfileView(volunteerName: $volunteerName)
                AllTasksView()
                    .tabItem(){
                        Image(systemName: "list.bullet.rectangle.portrait")
                        Text("Available Tasks")
                    }
                    .tag(Tabs.Tasks)
                VolunteerProfile(volunteerName: $volunteerName)
                    .tabItem(){
                        Image(systemName: "person")
                        Text("Profile")
                    }
                    .tag(Tabs.Profile)
                    .accentColor(.white)
            }
            .navigationTitle(selectedTab.rawValue)
            .navigationBarTitleDisplayMode(.inline)
            .background(
                NavigationLink(destination: chooseDestination(), isActive: $isLinkActive) {
                    EmptyView()
                }
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: {
                            self.isLinkActive = true
                            self.isFirstAidClicked = true
                        }, label: {
                            Label(title: {Text("First Aid Manual")}, icon: {Image(systemName: "info")})
                        })
                        Button(action:{
                            self.isLinkActive = true
                            self.isLogoutMenuClicked = true
                        }, label: {
                            Label(title: {Text("Log Out")}, icon: {Image(systemName: "rectangle.portrait.and.arrow.right")})
                        })
                    }
                label: {
                    Image("menu").resizable().frame(width:30, height:30).foregroundColor(.black).padding()
                }
                }           
            }// close toolbar
        }.navigationBarHidden(true)
    }
}

struct VolunteersNavBar_Previews: PreviewProvider {
    static var previews: some View {
        VolunteersNavBar(volunteerName: .constant(""))
    }
}

//
//  VolunteersNavBar.swift
//  Helper
//
//  Created by Annie Huynh on 18.4.2022.
//

import SwiftUI

struct VolunteersNavBar: View {
    @Binding var volunteerName: String
   
    var body: some View {
        NavigationView{
            TabView{
                VolunteerDashboard(volunteerName: $volunteerName)
                    .tabItem(){
                        Image(systemName: "house")
                        Text("Home")
                    }
                Location()
                    .tabItem(){
                        Image(systemName: "map")
                        Text("Location")
                    }
                AvailableTasksView()
                    .tabItem(){
                        Image(systemName: "list.bullet.rectangle.portrait")
                        Text("Available Tasks")
                    }
                VolunteerProfile()
                    .tabItem(){
                        Image(systemName: "person")
                        Text("Profile")
                    }
            }
        }.navigationBarHidden(true)
    }
}

struct VolunteersNavBar_Previews: PreviewProvider {
    static var previews: some View {
        VolunteersNavBar(volunteerName: .constant(""))
    }
}

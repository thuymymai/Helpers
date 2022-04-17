//
//  ContentView.swift
//  Helper
//
//  Created by SonDang, MyMai, AnHuynh on 1.4.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var userModel = UserViewModel()
    
    var body: some View {
        VStack{
            if userModel.users.isEmpty {
                ProgressView().onAppear(perform: {userModel.fetchData()})
            } else {
                List(userModel.users, id: \.self) {user in
                    Text(user.username!)
                }
                }
        }
//        TabView{
//            VolunteerDashboard()
//                .tabItem(){
//                    Image(systemName: "house")
//                    Text("Home")
//                }
//            AvailableTasksView()
//                .tabItem(){
//                    Image(systemName: "list.bullet.rectangle.portrait")
//                    Text("Available Tasks")
//                }
//            Location()
//                .tabItem(){
//                    Image(systemName: "map")
//                    Text("Location")
//                }
//            VolunteerProfile()
//                .tabItem(){
//                    Image(systemName: "person")
//                    Text("Profile")
//                }
//
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  Helper
//
//  Created by SonDang, MyMai, AnHuynh on 1.4.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var userModel = UserViewModel()
    @Environment(\.managedObjectContext) var context
    
    // fetching data from core data
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.user_id, ascending: true)]) var results: FetchedResults<User>
    
    var body: some View {
        VStack{
            // checking if core data exists
            if results.isEmpty {
                if userModel.users.isEmpty {
                    ProgressView().onAppear(perform: {userModel.fetchData(context: context)})
                } else {
                    List(userModel.users, id: \.self) {user in
                        Text(user.username!)
                    }
                }
            } else {
//                List(results, id: \.self) {user in
//                    Text(user.password!)
                let _ = print("read from core \(results[1].username)")
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

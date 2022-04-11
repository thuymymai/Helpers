//
//  ContentView.swift
//  Helper
//
//  Created by SonDang, MyMai, AnHuynh on 1.4.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.user_id, ascending: true)], animation: .default)
    
    private var users: FetchedResults<User>
    
//    print("user: \(users)")
    var body: some View {
        TabView{
            VolunteerDashboard()
                .tabItem(){
                    Image(systemName: "house")
                    Text("Home")
                }
            AvailableTasksView()
                .tabItem(){
                    Image(systemName: "list.bullet.rectangle.portrait")
                    Text("Available Tasks")
                }
            Location()
                .tabItem(){
                    Image(systemName: "map")
                    Text("Location")
                }
            VolunteerProfile()
                .tabItem(){
                    Image(systemName: "person")
                    Text("Profile")
                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

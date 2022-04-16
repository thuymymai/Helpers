//
//  ContentView.swift
//  Helper
//
//  Created by SonDang, MyMai, AnHuynh on 1.4.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            FrontScreen()
                .tabItem(){
                    Image(systemName: "house")
                    Text("Home")
                }
            MapView()
                .tabItem(){
                    Image(systemName: "map")
                    Text("Map")
                }
            UploadForm()
                .tabItem(){
                    Image(systemName: "list.bullet.rectangle.portrait")
                    Text("New Task")
                }
            Profile()
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

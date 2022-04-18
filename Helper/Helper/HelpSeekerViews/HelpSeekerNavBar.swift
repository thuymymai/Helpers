//
//  TabView.swift
//  Helper
//
//  Created by Mai Thuỳ My on 18.4.2022.
//

import SwiftUI

struct HelpSeekerNavBar: View {
    var body: some View {
        NavigationView {
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
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct HelpSeekerNavBar_Previews: PreviewProvider {
    static var previews: some View {
        HelpSeekerNavBar()
    }
}

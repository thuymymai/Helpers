//
//  TabView.swift
//  Helper
//
//  Created by Mai Thuỳ My on 18.4.2022.
//

import SwiftUI

struct HelpSeekerNavBar: View {
    @Binding var helpseekerName: String
    
    var body: some View {
        NavigationView {
            TabView{
                FrontScreen()
                    .tabItem(){
                        Image(systemName: "house")
                        Text("Home")
                    }
                MapView(volunteerName: $helpseekerName)
                    .tabItem(){
                        Image(systemName: "map")
                        Text("Map")
                    }
                UploadForm(helpseekerName: $helpseekerName)
                    .tabItem(){
                        Image(systemName: "list.bullet.rectangle.portrait")
                        Text("New Task")
                    }
                Profile(helpseekerName: $helpseekerName)
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
        HelpSeekerNavBar(helpseekerName: .constant(""))
    }
}

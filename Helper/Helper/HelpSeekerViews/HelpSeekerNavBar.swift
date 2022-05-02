//
//  TabView.swift
//  Helper
//
//  Created by Mai Thuỳ My on 18.4.2022.
//

import SwiftUI

enum Tab: String {
    case Home
    case Location
    case Upload
    case Profile
}

struct HelpSeekerNavBar: View {
    @Binding var helpseekerName: String
    @State var currentTab: Tab = .Home
    
    var body: some View {
        NavigationView {
            TabView(selection: $currentTab){
                FrontScreen(helpseekerName: $helpseekerName)
                    .tabItem(){
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(Tab.Home)
                Location(volunteerName: $helpseekerName)
                    .tabItem(){
                        Image(systemName: "map")
                        Text("Location")
                    }
                    .tag(Tab.Location)
                UploadForm(helpseekerName: $helpseekerName)
                    .tabItem(){
                        Image(systemName: "list.bullet.rectangle.portrait")
                        Text("New Task")
                    }
                    .tag(Tab.Upload)
                Profile(helpseekerName: $helpseekerName)
                    .tabItem(){
                        Image(systemName: "person")
                        Text("Profile")
                    }
                    .tag(Tab.Profile)
            }
            .navigationTitle(currentTab.rawValue)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HelpSeekerNavBar_Previews: PreviewProvider {
    static var previews: some View {
        HelpSeekerNavBar(helpseekerName: .constant(""))
    }
}

//
//  LoginForm.swift
//  Helper
//
//  Created by Dang Son on 1.5.2022.
//

import SwiftUI
import CoreData
import CoreLocationUI
import MapKit

struct Form: View {
    
    // navigation
    @State private var toDashboard: Bool = false
    @State private var toRegister: Bool = false
    @State private var showAlert: Bool = false
    @State private var isLinkActive: Bool = false
    @State private var loginFailed = false
    
    
    // user related details
    @State private var userInfo: [User] = []
    @State private var taskInfo: [Task] = []
    @State private var availableTasks: [Task] = []
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var userName: String = ""
    
    // set up environment
    @StateObject var userModel = UserViewModel()
    @Environment(\.managedObjectContext) var context
    
    // get singleton from ContentView
    private let shared = ContentView.shared
    
    // fetching data from core data
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    
    var body: some View {
        ZStack{
            VStack {
                Text("Email")
                    .fontWeight(.medium)
                    .frame(maxWidth: 300, alignment: .leading)
                    .font(.system(size: 14))
                TextField("", text: $email)
                    .padding(.bottom, 20)
                    .background(Color("Background"))
                    .cornerRadius(5)
                Text("Password")
                    .fontWeight(.medium)
                    .frame(maxWidth: 300, alignment: .leading)
                    .font(.system(size: 14))
                    .padding(.top, 10)
                SecureField("", text: $password)
                    .padding(.bottom, 20)
                    .background(Color("Background"))
                    .cornerRadius(5)
            }
            .frame(width: 250)
            .padding(.top, -50)
            
            // conditional navigation for each flow
            NavigationLink( destination: chooseDestination(), isActive: self.$isLinkActive) {EmptyView()}
            
            // navigation to sign up page
            NavigationLink(destination: LandingPage().navigationBarHidden(true), isActive: self.$toRegister) { EmptyView() }
            Button(action: {
                self.userInfo = results.filter{$0.email?.lowercased() == email.lowercased()}
                let emailExists = results.map{$0.email?.lowercased()}.contains(email.lowercased())
                
                // reset to to the initial stage
                self.loginFailed = true
                if (userInfo.count > 0) {
                    // credentials check
                    if ( emailExists && userInfo[0].password == password) {
                        self.loginFailed.toggle()
                    }
                    // passing data
                    userName = userInfo[0].fullname!
                }
                self.showAlert.toggle()
            }) {
                Text("LOG IN")
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                    .frame(width: 130, height: 35)
                    .background(Color("Primary"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                
            }
            .padding(.top, 210)
            .alert(isPresented: $showAlert, content: {
                // alert when login is failed
                if self.loginFailed {
                    return  Alert(title: Text("Failed to login"), message: Text("Email or Password incorrect. Try again or Sign Up now"), primaryButton: .default(Text("Sign Up"), action: {
                        self.toRegister = true
                    }), secondaryButton: .default(Text("Try again")))
                } else {
                    // when log in successfully
                    // get current location from phone
                    let sharedLocation = shared.locationManager
                    
                    // update location of current user
                    if (sharedLocation.address != "" && userInfo.count > 0) {
                        if let index = results.firstIndex(where: {$0.email == userInfo[0].email}) {
                            results[index].location = sharedLocation.address
                            results[index].lat = sharedLocation.lat
                            results[index].long = sharedLocation.long
                        }
                        do {
                            try context.save()
                        } catch {
                            print(error)
                        }
                    }
                    // come to home page                       }
                    return Alert(title: Text("Welcome"), message: Text("You have now logged in"), dismissButton: .default(Text("OK"), action: {self.isLinkActive = true}))
                }
                })
        }
    }
    
    // function choose destination conditionally
    @ViewBuilder
    func chooseDestination() -> some View {
        if (userInfo.count > 0)  {
            if (userInfo[0].type?.lowercased() == "v") {
                VolunteersNavBar(volunteerName: $userName).navigationBarHidden(true)
            } else if (userInfo[0].type?.lowercased() == "h") {
                HelpSeekerNavBar(helpseekerName: $userName).navigationBarHidden(true)
            } else {
                EmptyView()
            }
        }
        
    }
}


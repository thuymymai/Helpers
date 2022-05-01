//
//  Login.swift
//  Helper
//
//  Created by Mai Thuỳ My on 9.4.2022.
//  Contributor Annie Huynh
//

import SwiftUI
import CoreData
import CoreLocationUI
import MapKit

struct Login: View {
 
    var body: some View {
        GeometryReader{geometry in
            NavigationView{
                ZStack{
                    Color("Background").edgesIgnoringSafeArea(.all)
                    VStack{
                        Image("Image-login")
                            .resizable()
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.3)
                            .padding(.top,-60)
                        Spacer()
                    }
                    VStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                                .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.4)
                                .shadow(radius: 5)
                            Form()
                        }
                        Image("Login")
                            .resizable()
                            .edgesIgnoringSafeArea(.all)
                            .padding(.top,30)
                    }.padding(.top, 190)
                }
            }
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}

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
    @State private var emails: [String?] = []
    @State private var userName: String = ""
    
    // set up environment
    @StateObject var userModel = UserViewModel()
    @Environment(\.managedObjectContext) var context
    
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
            NavigationLink(destination:
                            chooseDestination(), isActive: self.$isLinkActive
            ){EmptyView()}
            
            // navigation to sign up page
            NavigationLink(destination: LandingPage().navigationBarHidden(true), isActive: self.$toRegister) { EmptyView() }
            Button(action: {
                self.userInfo = results.filter{$0.email?.lowercased() == email.lowercased()}
                self.emails = results.map{$0.email?.lowercased()}
                let emailExists = self.emails.contains(email.lowercased())
               
                // reset to to the initial stage
                self.loginFailed = true
                if (userInfo.count > 0) {
                    // credentials check
                    if ( emailExists && userInfo[0].password == password){
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
                
            }.padding(.top, 210)
                .alert(isPresented: $showAlert, content: {
                    // alert when login is failed
                    if self.loginFailed {
                        return  Alert(title: Text("Failed to login"), message: Text("Email or Password incorrect. Try again or Sign Up now"), primaryButton: .default(Text("Sign Up"), action: {
                            self.toRegister = true
                        }), secondaryButton: .default(Text("Try again")))
                        // when log in successfully
                    } else {
                        // get current location
//                        let _ = DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        let sharedLocation = shared.locationManager
                            let _ = print("address is \(sharedLocation.address)")
                            let _ = print("lat is \(sharedLocation.lat)")
                            let _ = print("long is \(sharedLocation.long)")
                            
                            // update location of current user
                        if (sharedLocation.address != "" && userInfo.count > 0) {
                                let _ = print("start updating core data")
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
//                        }
                        return Alert(title: Text("Welcome"), message: Text("You have now logged in"), dismissButton: .default(Text("OK"), action: {self.isLinkActive = true}))
                    }
                })
        }
    }
    // function choose destination conditionally
    @ViewBuilder
    func chooseDestination() -> some View {
       
        
        if (userInfo.count > 0)  {
//            let _ = print("type of user login \(userInfo[0].type)")
            if  ( userInfo[0].type == "v") {
                VolunteersNavBar(volunteerName: $userName)
                    .navigationBarHidden(true)
            } else if (userInfo[0].type == "h") {
                HelpSeekerNavBar(helpseekerName: $userName).navigationBarHidden(true)
            } else {
                EmptyView()
            }
        }
        
    }
}


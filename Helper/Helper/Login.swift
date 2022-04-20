//
//  Login.swift
//  Helper
//
//  Created by Mai Thuỳ My on 9.4.2022.
//  Contributor Annie Huynh
//

import SwiftUI
import CoreData

struct Login: View {
    let persistenceController = PersistenceController.shared
    
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
                            Form().environment(\.managedObjectContext, persistenceController.container.viewContext)
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
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var toDashboard: Bool = false
    @State private var toRegister: Bool = false
    @State private var showAlert: Bool = false
    @State private var isLinkActive: Bool = false
    @State private var loginFailed = false
    
    // set up environment
    @StateObject var userModel = UserViewModel()
    @Environment(\.managedObjectContext) var context
    
    // fetching data from core data
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.user_id, ascending: true)]) var results: FetchedResults<User>
    
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
                let emails = results.map{$0.email}
                let passwords = results.map{$0.password}
                let userExists = emails.contains(email.lowercased()) && passwords.contains(password)
                
                // reset to to the initial stage
                self.loginFailed = false
                if (!userExists){
                    self.loginFailed.toggle()
                }
                self.showAlert.toggle()
            }) {
                Text("LOG IN")
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                    .frame(width: 100, height: 35)
                    .background(Color("Primary"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                
            }.padding(.top, 210)
                .alert(isPresented: $showAlert, content: {
                    // alert when login is failed
                    if self.loginFailed {
                        return  Alert(title: Text("Failed to login"), message: Text("Check your credentials and try again or Sign Up now"), primaryButton: .default(Text("Sign Up"), action: {
                            self.toRegister = true
                        }), secondaryButton: .default(Text("Try again"), action: {resetForm()}))
                    // when log in successfully
                    } else {
                        return  Alert(title: Text("Welcome"), message: Text("You have now logged in"), dismissButton: .default(Text("OK"), action: {self.isLinkActive = true}))
                    }
                })
        }
    }
    // function choose destination conditionally
    @ViewBuilder
    func chooseDestination() -> some View {
        let emails = results.map{$0.email}
        let passwords = results.map{$0.password}
        let userInfo = results.filter{$0.email == email.lowercased()}
        let checkUserExists = emails.contains(email.lowercased()) && passwords.contains(password)
        
        if (userInfo.count > 0)  {
            if  (checkUserExists && userInfo[0].type == "v") {
                VolunteersNavBar().navigationBarHidden(true)
            } else if (checkUserExists && userInfo[0].type == "h") {
                HelpSeekerNavBar().navigationBarHidden(true)
            } else {
                EmptyView()
            }
        }
        
    }
    // reset form fields when email or password is incorrect
    func resetForm(){
        email = ""
        password = ""
    }
    
}


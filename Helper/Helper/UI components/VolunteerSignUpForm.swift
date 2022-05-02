//
//  VolunteerSignUpForm.swift
//  Helper
//
//  Created by Dang Son on 1.5.2022.
//

import Foundation
import SwiftUI
import CoreData

struct VolunteerSignUpForm: View {
    
    @State var fullname: String = ""
    @State var phone: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirm: String = ""
    
    @State private var isLinkActive = false
    @State private var signupFailed = false
    @State private var showAlert: Bool = false
    @State private var passwordFailed = false
    @State private var emptyField = false
    @State private var emailCheck = false
    @State private var phoneCheck = false
    
    // set up environment
    @StateObject var userModel = UserViewModel()
    @Environment(\.managedObjectContext) var context
    
    // fetching data from core data
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading) {
                Text("Full name")
                    .fontWeight(.semibold)
                    .font(.system(size: 14))
                TextField("", text: $fullname)
                    .padding(.bottom, 20)
                    .background(Color("Background"))
                    .cornerRadius(5)
                Text("Email")
                    .fontWeight(.semibold)
                    .font(.system(size: 14))
                    .padding(.top, 10)
                TextField("", text: $email)
                    .padding(.bottom, 20)
                    .background(Color("Background"))
                    .cornerRadius(5)
                Text("Phone number")
                    .fontWeight(.semibold)
                    .font(.system(size: 14))
                    .padding(.top, 10)
                TextField("", text: $phone)
                    .padding(.bottom, 20)
                    .background(Color("Background"))
                    .cornerRadius(5)
                Text("Password")
                    .fontWeight(.semibold)
                    .font(.system(size: 14))
                    .padding(.top, 10)
                SecureField("", text: $password)
                    .padding(.bottom, 20)
                    .background(Color("Background"))
                    .cornerRadius(5)
                Text("Confirm Password")
                    .fontWeight(.semibold)
                    .font(.system(size: 14))
                    .padding(.top, 10)
                SecureField("", text: $confirm)
                    .padding(.bottom, 20)
                    .background(Color("Background"))
                    .cornerRadius(5)
                
            }
            .frame(width: 260)
            .padding(.top, 50)
            
            NavigationLink( destination: RegisterAvailability(fullname: $fullname, email: $email, phone: $phone, password: $password)
                .navigationBarHidden(true), isActive: $isLinkActive) {EmptyView()}
            Button(action: {
                let userExists = results.map{$0.email?.lowercased()}.contains(email.lowercased())
                self.signupFailed = false
                if (userExists){
                    self.signupFailed.toggle()
                }
                self.emptyField = false
                if(fullname == "" || email == "" || phone == ""  || password == "" || confirm == "") {
                    self.emptyField.toggle()
                }
                self.emailCheck = false
                if(email.isValidEmail == false) {
                    self.emailCheck.toggle()
                }
                self.phoneCheck = false
                if(phone.isNumber == false) {
                    self.phoneCheck.toggle()
                }
                self.passwordFailed = false
                if(confirm != password){
                    self.passwordFailed.toggle()
                }
                self.showAlert.toggle()
            }) {
                Text("NEXT")
                    .font(.system(size: 16))
                    .foregroundColor(Color("Primary"))
                    .fontWeight(.bold)
                Image(systemName: "arrow.forward.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color("Primary"))
                
            }
            .padding(.top, 550)
            .alert(isPresented: $showAlert, content: {
                // alert when something wrong
                if self.signupFailed {
                    return Alert(title: Text("Sign up failed"), message: Text("Email already taken!"), dismissButton: .default(Text("Try again")))
                } else if self.emptyField {
                    return Alert(title: Text("Sign up failed"), message: Text("All fields are required!"), dismissButton: .default(Text("Try again")))
                } else if self.emailCheck {
                    return Alert(title: Text("Sign up failed"), message: Text("Please enter valid email!"), dismissButton: .default(Text("Try again")))
                } else if self.phoneCheck {
                    return Alert(title: Text("Sign up failed"), message: Text("Phone must be number!"), dismissButton: .default(Text("Try again")))
                } else if self.passwordFailed {
                    return Alert(title: Text("Sign up failed"), message: Text("Passwords do not match!"), dismissButton: .default(Text("Try again")))
                } else {
                    // alert when successfull and go to next page
                    return  Alert(title: Text("Success!"), message: Text("You have set up your basic information!"), dismissButton: .default(Text("OK"), action: {self.isLinkActive = true}))
                }
            })
        }
        
    }
}

//
//  VolunteerSignUp.swift
//  Helper
//
//  Created by Annie Huynh on 18.4.2022.
//

import SwiftUI

struct VolunteerSignUp: View {
    var body: some View {
        GeometryReader { geometry in
            NavigationView{
                ZStack(alignment: .top){
                    Color("Background").edgesIgnoringSafeArea(.all)
                    ZStack(alignment: .top){
                        Image("BG Mask").edgesIgnoringSafeArea(.all)
                        Text("Your move makes someone's life better.\n Join Helpers today")
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                            .frame(maxWidth: geometry.size.width * 0.7, alignment: .center)
                            .foregroundColor(.white)
                            .padding(.top, -40)
                            .multilineTextAlignment(.center)
                    }.offset(y:-60)
                    Spacer()
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.8)
                            .shadow(radius: 5)
                           
                        VolunteerSignUpForm().offset(y:-40)
                    }.padding(.top,-10)
                }
            }
        }
        
    }
}

struct VolunteerSignUp_Previews: PreviewProvider {
    static var previews: some View {
        VolunteerSignUp()
    }
}

struct VolunteerSignUpForm: View {
    
    @State var fullname: String = ""
    @State var phone: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirm: String = ""
    @State var isLinkActive = false
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
            NavigationLink(
                destination: RegisterAvailability(fullname: $fullname, email: $email, phone: $phone, password: $password).navigationBarHidden(true), isActive: $isLinkActive) {EmptyView()}
                    Button(action: {
//                        let emails = results.map{$0.email}
//                        let userExists = emails.contains(email.lowercased())
//                        self.signupFailed = false
//                        if (userExists){
//                            self.signupFailed.toggle()
//                        }
//                        self.emptyField = false
//                        if(fullname == "" || email == "" || phone == ""  || password == "" || confirm == "") {
//                            self.emptyField.toggle()
//                        }
//                        self.emailCheck = false
//                        if(email.isValidEmail == false) {
//                            self.emailCheck.toggle()
//                        }
//                        self.phoneCheck = false
//                        if(phone.isNumber == false) {
//                            self.phoneCheck.toggle()
//                        }
//                        self.passwordFailed = false
//                        if(confirm != password){
//                            self.passwordFailed.toggle()
//                        }
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
                        // alert when email taken
//                        if self.signupFailed {
//                            return Alert(title: Text("Sign up failed"), message: Text("Email already taken!"), dismissButton: .default(Text("Try again")))
//                            //alert when password not match
//                        } else if self.emptyField {
//                            return Alert(title: Text("Sign up failed"), message: Text("All fields are required!"), dismissButton: .default(Text("Try again")))
//                        } else if self.emailCheck {
//                            return Alert(title: Text("Sign up failed"), message: Text("Please enter valid email!"), dismissButton: .default(Text("Try again")))
//                        } else if self.phoneCheck {
//                            return Alert(title: Text("Sign up failed"), message: Text("Phone must be number!"), dismissButton: .default(Text("Try again")))
//                        } else if self.passwordFailed {
//                            return Alert(title: Text("Sign up failed"), message: Text("Passwords do not match!"), dismissButton: .default(Text("Try again")))
//                        } else {
                            return  Alert(title: Text("Success!"), message: Text("You have set up your basic information!"), dismissButton: .default(Text("OK"), action: {self.isLinkActive = true}))
                        //}
                    })
        }
        
    }
}


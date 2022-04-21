//
//  SwiftUIView.swift
//  Helper
//
//  Created by Mai Thuỳ My on 8.4.2022.
//

import SwiftUI

struct Signup: View {
    var body: some View {
        NavigationView{
            ZStack(alignment: .top){
                Color("Background").edgesIgnoringSafeArea(.all)
                ZStack(alignment: .top){
                    Image("BG Mask").edgesIgnoringSafeArea(.all)
                    Text("Join Helpers and receive assistance to all your needs.")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .frame(maxWidth: 280, alignment: .center)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.top, 50)
                }
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .frame(width: 300, height: 550)
                        .shadow(radius: 5)
                        .padding(.top, 100)
                    FormView()
                }.padding(.top, 50)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
        
    }
}

struct Signup_Previews: PreviewProvider {
    static var previews: some View {
        Signup()
    }
}

struct FormView: View {
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
            VStack {
                Text("Full name")
                    .fontWeight(.medium)
                    .frame(maxWidth: 300, alignment: .leading)
                    .font(.system(size: 14))
                TextField("", text: $fullname)
                    .padding(.bottom, 20)
                    .background(Color("Background"))
                    .cornerRadius(5)
                Text("Email")
                    .fontWeight(.medium)
                    .frame(maxWidth: 300, alignment: .leading)
                    .font(.system(size: 14))
                    .padding(.top, 10)
                TextField("", text: $email)
                    .padding(.bottom, 20)
                    .background(Color("Background"))
                    .cornerRadius(5)
                Text("Phone number")
                    .fontWeight(.medium)
                    .frame(maxWidth: 300, alignment: .leading)
                    .font(.system(size: 14))
                    .padding(.top, 10)
                TextField("", text: $phone)
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
                Text("Confirm Password")
                    .fontWeight(.medium)
                    .frame(maxWidth: 300, alignment: .leading)
                    .font(.system(size: 14))
                    .padding(.top, 10)
                SecureField("", text: $confirm)
                    .padding(.bottom, 20)
                    .background(Color("Background"))
                    .cornerRadius(5)
            }
            .frame(width: 250)
            .padding(.top, 50)
            NavigationLink(
                destination: MedicalInfo(fullname: $fullname, email: $email, phone: $phone, password: $password).navigationBarHidden(true), isActive: $isLinkActive) {EmptyView()}
            Button(action: {
                let emails = results.map{$0.email}
                let userExists = emails.contains(email.lowercased())
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
                    .frame(width: 70, height: 50)
                Image(systemName: "arrow.forward.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color("Primary"))
                
            }
            .padding(.top, 550)
            .frame(alignment: .trailing)
            .alert(isPresented: $showAlert, content: {
                // alert when email taken
                if self.signupFailed {
                    return Alert(title: Text("Sign up failed"), message: Text("Email already taken!"), dismissButton: .default(Text("Try again")))
                    //alert when password not match
                } else if self.emptyField {
                    return Alert(title: Text("Sign up failed"), message: Text("All fields are required!"), dismissButton: .default(Text("Try again")))
                } else if self.emailCheck {
                    return Alert(title: Text("Sign up failed"), message: Text("Please enter valid email!"), dismissButton: .default(Text("Try again")))
                } else if self.phoneCheck {
                    return Alert(title: Text("Sign up failed"), message: Text("Phone must be number!"), dismissButton: .default(Text("Try again")))
                } else if self.passwordFailed {
                    return Alert(title: Text("Sign up failed"), message: Text("Passwords do not match!"), dismissButton: .default(Text("Try again")))
                } else {
                    return  Alert(title: Text("Success!"), message: Text("You have set up your basic information!"), dismissButton: .default(Text("OK"), action: {self.isLinkActive = true}))
                }
            })
        }
    }
}

extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}

extension String {
    public var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}

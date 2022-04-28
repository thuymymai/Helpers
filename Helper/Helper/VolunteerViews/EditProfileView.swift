//
//  EditProfileView.swift
//  Helper
//
//  Created by Annie Huynh on 25.4.2022.
//

import SwiftUI

struct EditProfileView: View {
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    @State private var showingSheet = false
    @Binding var volunteerName: String

    @State var fullname: String = ""
    @State var phone: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirm: String = ""
    @State var userInfo: [User]  = []
    @State var isLinkActive = false
 
    func getUserInfo() -> User {
        self.userInfo = results.filter{$0.email?.lowercased() == email.lowercased()}
        for user in results {
            if (user.fullname == volunteerName) {
                print("user info \(user)")
                return user
            }
        }
        return User()
    }
    var body: some View {
        VStack(alignment: .leading) {
            
            let user = getUserInfo()
           
            Text("Full name")
                .fontWeight(.semibold)
                .font(.system(size: 14))
            TextField("\(user.fullname!)", text: $fullname)
                .padding(.bottom, 20)
                .background(Color("Background"))
                .cornerRadius(5)
            Text("Email")
                .fontWeight(.semibold)
                .font(.system(size: 14))
                .padding(.top, 10)
            TextField("\(user.email!)", text: $email)
                .padding(.bottom, 20)
                .background(Color("Background"))
                .cornerRadius(5)
            Text("Phone number")
                .fontWeight(.semibold)
                .font(.system(size: 14))
                .padding(.top, 10)
            TextField("\(user.phone!)", text: $phone)
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
//        Button(action:{}){
//            Text("SAVE")
//                .fontWeight(.bold)
//                .font(.system(size: 14))
//                .frame(width: 100, height: 35)
//                .background(Color("Primary"))
//                .foregroundColor(.white)
//                .cornerRadius(10)
//        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(volunteerName: .constant(""))
    }
}

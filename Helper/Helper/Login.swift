//
//  Login.swift
//  Helper
//
//  Created by Mai Thuỳ My on 9.4.2022.
//

import SwiftUI
import CoreData

struct Login: View {
    let persistenceController = PersistenceController.shared
    
    var body: some View {
        ZStack{
            Color("Background").edgesIgnoringSafeArea(.all)
            VStack{
                Image("Image-login")
                    .resizable()
                    .frame(width: 300, height: 200)
                    .padding(.top, 50)
                Spacer()
            }
            VStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .frame(width: 300, height: 300)
                        .shadow(radius: 5)
                    Form().environment(\.managedObjectContext, persistenceController.container.viewContext)
                    
                }
                Image("Login")
            }.padding(.top, 280)
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}

struct Form: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var toDashboard: Bool = false
    
    // set up environment
    @StateObject var userModel = UserViewModel()
    @Environment(\.managedObjectContext) var context

    // fetching data from core data
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.user_id, ascending: true)]) var results: FetchedResults<User>
  
    func submit() {
        let emails = results.map{$0.email}
//        let passwords = results.map{$0.password}
//        print("count \(results.count)")
//        print("result \(results)")
        print("email \(emails)")
//        print("password \(passwords)")
//        if (emails.contains(email) && passwords.contains(password)) {
//            self.toDashboard = true
//        } else {
//            print("wrong information")
//        }
        if (emails.contains(email.lowercased())) {
            print("user contain true")
        } else {
            print("user contain false")
        }
    }
    
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
            NavigationLink(destination: VolunteersNavBar().navigationBarBackButtonHidden(true), isActive: self.$toDashboard) { EmptyView() }
            Button(action: {submit()}) {
                Text("LOG IN")
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                    .frame(width: 100, height: 35)
                    .background(Color("Primary"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 210)
        }
        
    }
}

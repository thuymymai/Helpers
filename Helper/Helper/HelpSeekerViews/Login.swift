//
//  Login.swift
//  Helper
//
//  Created by Mai Thuỳ My on 9.4.2022.
//

import SwiftUI

struct Login: View {
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
                    Form()
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
            Button(action: {}) {
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

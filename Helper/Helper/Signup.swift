//
//  SwiftUIView.swift
//  Helper
//
//  Created by Mai Thuỳ My on 8.4.2022.
//

import SwiftUI

struct Signup: View {
    var body: some View {
        ZStack{
            Color("Background").edgesIgnoringSafeArea(.all)
            
            VStack{
                ZStack{
                    Image("BG Mask").edgesIgnoringSafeArea(.all)
                    Text("Join Helpers and receive assistance to all your needs.")
                        .fontWeight(.medium)
                        .padding()
                        .padding(.top, -50)
                        .frame(maxWidth: 300, alignment: .center)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }.padding(.top, -80)
                Spacer()
            }
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(width: 300, height: 570)
                    .shadow(radius: 5)
                    .padding(.top, 70)
                FormView()
            }
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
            .padding()
            Button(action: {}) {
                Text("NEXT")
                    .font(.system(size: 16))
                    .foregroundColor(Color("Primary"))
                    .fontWeight(.bold)
                Text(">")
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                    .frame(width: 30, height: 30)
                    .background(Color("Background"))
                    .foregroundColor(Color("Primary"))
                    .cornerRadius(50)
            }
            .padding(.top, 550)
            .frame(alignment: .trailing)
        }
        
    }
}

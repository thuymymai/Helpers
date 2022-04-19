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
                    }
                    Spacer()
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.7)
                            .shadow(radius: 5)
                            .padding(.top, 80)
                        VolunteerSignUpForm()
                    }
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
                    destination: RegisterAvailability().navigationBarHidden(true), isActive: $isLinkActive) {
                        Button(action: {
                            self.isLinkActive = true
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
                        
                    }
            }
            
        }
    }


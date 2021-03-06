//
//  LandingPage.swift
//  Helper
//
//  Created by Dang Son, My Mai, An Huynh on 5.4.2022.
//

import SwiftUI

struct LandingPage: View {
    @State var showAlert: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .top){
                VStack{
                    VStack{
                        Text("Join the community.")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                        Text("See the world together.")
                            .fontWeight(.semibold)
                            .font(.system(size: 18))
                        ImageView()
                    }
                    .frame(maxHeight: .infinity, alignment: .leading)
                    .padding(.top)
                    
                    HStack(spacing: 100){
                        VStack{
                            Text("100,000")
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                            Text("help seekers")
                                .font(.system(size: 16))
                        }
                        VStack{
                            Text("200,000")
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                            Text("volunteers")
                                .font(.system(size: 16))
                        }
                    }
                    .padding(.bottom, 80)
                    
                    Spacer()
                    ButtonView()
                    HStack{
                        Text("Already have an account?")
                        NavigationLink(destination: Login()
                            .navigationBarHidden(true), label: {
                                Text("Login")
                                    .underline()
                                    .bold()
                                    .foregroundColor(Color("Primary")
                                    )
                            })
                    }
                    .padding(.bottom,10)
                    .padding(.horizontal, 40)
                }
            }
            .offset(y:-20)
        }
    }
}

struct LandingPage_Previews: PreviewProvider {
    static var previews: some View {
        LandingPage()
    }
}

struct ImageView: View {
    var body: some View {
        Image("landing-image")
            .resizable()
            .frame(width: 320, height: 250)
    }
}

struct ButtonView: View {
    @State var isHelpSeekerActive = false
    @State var isVolunteerActive = false
    
    var body: some View {
        VStack{
            NavigationLink( destination: Signup().navigationBarHidden(true), isActive: $isHelpSeekerActive) {
                Button(action: {self.isHelpSeekerActive = true}) {
                    Text("I need assistant")
                        .fontWeight(.bold)
                        .font(.system(size: 18))
                        .frame(width: 250, height: 50)
                        .background(Color("Primary"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom, 10)
            }
            NavigationLink( destination: VolunteerSignUp().navigationBarHidden(true), isActive: $isVolunteerActive) {
                Button(action: {self.isVolunteerActive = true}) {
                    Text("I'd like to volunteer")
                        .fontWeight(.bold)
                        .font(.system(size: 18))
                        .frame(width: 250, height: 50)
                        .background(Color("Background"))
                        .foregroundColor(Color("Primary"))
                        .cornerRadius(10)
                }
            }
        }
        .padding(.bottom, 50)
    }
}

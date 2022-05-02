//
//  SwiftUIView.swift
//  Helper
//
//  Created by Mai Thuỳ My on 8.4.2022.
//

import SwiftUI

struct Signup: View {
    var body: some View {
        GeometryReader{ geometry in
            NavigationView{
                ZStack(alignment: .top){
                    Color("Background").edgesIgnoringSafeArea(.all)
                    ZStack(alignment: .top){
                        Image("BG Mask").edgesIgnoringSafeArea(.all)
                        Text("Join Helpers and receive assistance to all your needs.")
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                            .frame(maxWidth:  geometry.size.width * 0.7, alignment: .center)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.top, -10)
                    }
                    Spacer()
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.7)
                            .shadow(radius: 5)
                        HelpseekerSignUpForm()
                            .offset(y:-40)
                    }
                    .padding(.top, 50)
                }
            }
        }
    }
}

struct Signup_Previews: PreviewProvider {
    static var previews: some View {
        Signup()
    }
}


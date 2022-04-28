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
                            .offset(y:45)
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



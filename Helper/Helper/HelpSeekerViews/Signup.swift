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
                }.offset(y:-60)
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .frame(width: 300, height: 550)
                        .shadow(radius: 5)
                    FormView().offset(y:-50)
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


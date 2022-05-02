//
//  Login.swift
//  Helper
//
//  Created by Mai Thuỳ My on 9.4.2022.
//  Contributor Annie Huynh
//

import SwiftUI

struct Login: View {
    
    var body: some View {
        GeometryReader{geometry in
            NavigationView{
                ZStack{
                    Color("Background").edgesIgnoringSafeArea(.all)
                    VStack{
                        Image("Image-login")
                            .resizable()
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.3)
                            .padding(.top,-100)
                        Spacer()
                    }
                    VStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                                .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.4)
                                .shadow(radius: 5)
                            Form()
                        }
                        Image("Login")
                            .resizable()
                            .edgesIgnoringSafeArea(.all)
                            .padding(.top,30)
                    }.padding(.top, 150)
                }
            }
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}


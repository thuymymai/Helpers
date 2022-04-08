//
//  LandingPage.swift
//  Helper
//
//  Created by Mai Thuỳ My on 5.4.2022.
//

import SwiftUI

struct LandingPage: View {
    var body: some View {
        ZStack{
            VStack{
                Text("Join the community.")
                    .fontWeight(.bold)
                    .font(.system(size: 16))
                Text("See the world together.")
                    .fontWeight(.bold)
                    .font(.system(size: 16))
                ImageView().padding(.top, -14)
            }
            HStack(spacing: 100){
                VStack{
                    Text("100,000")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                    Text("help seekers")
                        .font(.system(size: 14))
                }
                VStack{
                    Text("200,000")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                    Text("volunteers")
                        .font(.system(size: 14))
                }
            }.padding(.top, 10)
            ButtonView()
            DropDownMenu()
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
            .frame(width: 300, height: 230)
        Spacer()
    }
}

struct ButtonView: View {
    var body: some View {
        VStack{
            Button(action: {}) {
                Text("I need assistant")
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                    .frame(width: 200, height: 40)
                    .background(Color("Primary"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }.padding(.bottom, 10)
            Button(action: {}) {
                Text("I'd like to volunteer")
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                    .frame(width: 200, height: 40)
                    .background(Color("Background"))
                    .foregroundColor(Color("Primary"))
                    .cornerRadius(10)
            }
        }.padding(.top, 280)
    }
}

struct DropDownMenu: View {
    @State private var selection = "English"
    let languages = ["English", "Finnish", "Swedish"]
    
    var body: some View {
            Picker("Select language", selection: $selection) {
                ForEach(languages, id: \.self) {
                    Text($0)
                        .frame(width: 110, height: 110)
                        .background(.blue)
                }
            }
            .padding(.top, 450)
            .pickerStyle(.menu)
    }
}

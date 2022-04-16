//
//  LandingPage.swift
//  Helper
//
//  Created by Mai Thuỳ My on 5.4.2022.
//

import SwiftUI

struct LandingPage: View {
    var body: some View {
        NavigationView{
            ZStack(alignment: .top){
                VStack{
                    VStack{
                        Text("Join the community.")
                            .fontWeight(.semibold)
                            .font(.system(size: 18))
                        Text("See the world together.")
                            .fontWeight(.semibold)
                            .font(.system(size: 18))
                        ImageView()
                    }.frame(maxHeight: .infinity, alignment: .leading)
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
                    }.padding(.bottom, 100)
                    Spacer()
                    ButtonView()
                    DropDownMenu()
                }

            }
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
    @State var isLinkActive = false
    
    var body: some View {
        VStack{
            NavigationLink(
                destination: Signup().navigationBarHidden(true), isActive: $isLinkActive) {
                    Button(action: {self.isLinkActive = true}) {
                        Text("I need assistant")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                            .frame(width: 250, height: 50)
                            .background(Color("Primary"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }.padding(.bottom, 10)
                }
            
            Button(action: {}) {
                Text("I'd like to volunteer")
                    .fontWeight(.bold)
                    .font(.system(size: 16))
                    .frame(width: 250, height: 50)
                    .background(Color("Background"))
                    .foregroundColor(Color("Primary"))
                    .cornerRadius(10)
            }
        }.padding(.bottom, 50)
        
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
        }.padding(.bottom, 20)
        .pickerStyle(.menu)
    }
}

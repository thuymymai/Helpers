//
//  FrontScreen.swift
//  Helper
//
//  Created by Mai Thuỳ My on 10.4.2022.
//

import SwiftUI

struct FrontScreen: View {
    var body: some View {
        NavigationView {
            ZStack(alignment: .top){
                Color("White")
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    HStack(alignment: .top){
                        Spacer()
                        VStack{
                            Text("Karaportti 2, Espoo")
                                .font(.system(size: 16))
                                .padding(.bottom, 2)
                            NavigationLink(
                                destination: HelpSeekerMapView(),
                                label: {
                                    HStack {
                                        Text("See your location")
                                            .bold()
                                            .font(.system(size: 16))
                                            .foregroundColor(Color("Primary"))
                                        Image(systemName: "location.fill")
                                            .foregroundColor(.red)
                                    }
                                })
                        }.padding(.top, 30)
                    }
                    .padding(.bottom, 50)
                    .padding(.trailing, 10)
                    
                    Text("Emergency help needed?")
                        .bold()
                        .font(.system(size: 24))
                        .padding(.bottom, 5)
                    Text("Press button to call the nearest volunteer")
                        .padding(.bottom, 20)
                        .font(.system(size: 18))
                    EmergencyButton()
                    Text("First-aid manual")
                        .bold()
                        .padding(.top, 100)
                        .font(.system(size: 20))
                    TabView{
                        FirstAidManual()
                        FirstAidManual()
                        FirstAidManual()
                    }.tabViewStyle(.page(indexDisplayMode: .never))
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct FrontScreen_Previews: PreviewProvider {
    static var previews: some View {
        FrontScreen()
    }
}

struct EmergencyButton: View {
    var body: some View {
        ZStack{
            Circle()
                .fill(Color("Background"))
                .frame(width: 300, height: 170)
                .shadow(color: .gray, radius: 5, x: 0, y: 5)
            Image("emergency-button")
        }
        
    }
}

struct FirstAidManual: View {
    var body: some View {
        HStack{
            NavigationLink(destination: FirstAid(), label: {
                ZStack{
                    Rectangle()
                        .fill(Color("Background"))
                        .frame(width: 150, height: 120)
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                    VStack{
                        Text("Choke")
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                            .frame(maxWidth: 120, alignment: .leading)
                            .font(.system(size: 16))
                        HStack{
                            Image(systemName: "arrow.right.circle.fill")
                                .frame(maxWidth: 60, alignment: .leading)
                                .font(.system(size: 22))
                                .foregroundColor(Color("Primary"))
                                .padding(.top)
                            Image("choke")
                        }
                    }
                }.padding()
            })
            ZStack{
                Rectangle()
                    .fill(Color("Background"))
                    .frame(width: 150, height: 120)
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
                VStack{
                    Text("Broken bone")
                        .fontWeight(.semibold)
                        .frame(maxWidth: 120, alignment: .leading)
                        .font(.system(size: 16))
                    HStack{
                        Image(systemName: "arrow.right.circle.fill")
                            .frame(maxWidth: 60, alignment: .leading)
                            .font(.system(size: 22))
                            .foregroundColor(Color("Primary"))
                            .padding(.top)
                        Image("broken-bone")
                    }
                }
            }
        }.padding(.top, -50)
    }
}

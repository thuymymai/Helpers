//
//  TaskDetailView.swift
//  Helper
//
//  Created by Annie Huynh on 7.4.2022.
//


import SwiftUI

struct TaskDetailView: View {
    
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack{
                ContactInfo()
                Divider()
                
                DisabilityInformation()
            }.frame(width: 330, height: 300)
                .background(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            
        }
        
    }
    
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView()
    }
}

struct DisabilityInformation: View {
    var body: some View {
        VStack(spacing:10){
            HStack(spacing:-10) {
                Text("Diability :")
                    .font(.body)
                    .bold()
                    .foregroundColor(.black)
                
                
                Text("wheelchair")
                    .font(.body)
                    .foregroundColor(.black)
                    .padding(.leading, 20)
                Spacer()
            }
            
            HStack(spacing:-10) {
                Text("Chornic disease :")
                    .font(.body)
                    .bold()
                    .foregroundColor(.black)
                
                
                Text("heart disease")
                    .font(.body)
                    .foregroundColor(.black)
                    .padding(.leading, 20)
                Spacer()
            }
            HStack(spacing:-10) {
                Text("Allergies :")
                    .font(.body)
                    .bold()
                    .foregroundColor(.black)
                
                
                Text("Pollen, animal fur")
                    .font(.body)
                    .foregroundColor(.black)
                    .padding(.leading, 20)
                Spacer()
            }
        }
        .padding(.vertical)
        .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

struct ContactInfo: View {
    var body: some View {
        VStack(spacing:0) {
            Image("avatar")
                .resizable()
                .frame(width: 70, height: 70)
                .cornerRadius(50)
                .padding(.top, 20)
            
            Text("Help seeker name")
                .bold()
                .padding(.all, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            HStack(spacing:30) {
                VStack(spacing:15) {
                    Image(systemName: "phone.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Call")
                        .padding(.top, -10)
                }
                
                VStack(spacing:15) {
                    Image(systemName: "message")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Message")
                        .padding(.top, -10)
                }
            }
        }.padding(.top,0)
    }
}

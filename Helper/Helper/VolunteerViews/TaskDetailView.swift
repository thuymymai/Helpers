//
//  TaskDetailView.swift
//  Helper
//
//  Created by Annie Huynh on 7.4.2022.
//


import SwiftUI

struct TaskDetailView: View {
    
    // passing helpseeker data  
    @Binding var taskTitle: String
    @Binding var helpseeker: String
    @Binding var location: String
    @Binding var time: Date?
    @Binding var desc: String
    @Binding var need: String
    @Binding var chronic: String
    @Binding var allergies: String
    
    var body: some View {
        GeometryReader {geometry in
            ZStack{
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                ScrollView{
                    VStack{
                        ZStack {
                            VStack{
                                ContactInfo(helpseeker: helpseeker)
                                Divider()
                                DisabilityInformation(need: need, chronic: chronic, allergies: allergies)
                            }.frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.4)
                                .background(.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .padding(.top,30)
                        }
                        VStack(alignment: .leading, spacing: 10){
                            TaskTitle(taskTitle: taskTitle)
                            Address(location: location)
                            TimeNeeded(time:time)
                            TaskDescription(desc: desc)
                        }.padding(.horizontal)
                            .offset(y:20)
                    }
                }
                
            }
        }
        
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(taskTitle: .constant(""), helpseeker: .constant(""), location: .constant(""),
                       time: .constant(Date()), desc: .constant(""), need: .constant(""),
                       chronic: .constant(""), allergies: .constant(""))
    }
}

struct DisabilityInformation: View {
    var need: String
    var chronic: String
    var allergies: String
    
    var body: some View {
        VStack(spacing:5){
            HStack(spacing:-10) {
                Text("Diability :")
                    .font(.body)
                    .bold()
                    .foregroundColor(.black)
                    .padding(.leading, 10)
                
                Text(need.isEmpty ? "wheelchair" : need)
                    .font(.body)
                    .foregroundColor(.black)
                    .padding(.leading, 20)
                Spacer()
            }
            
            HStack(spacing:-10) {
                Text("Chronic disease :")
                    .font(.body)
                    .bold()
                    .foregroundColor(.black)
                    .padding(.leading, 10)
                Text(chronic.isEmpty ? "None" : chronic)
                    .font(.body)
                    .foregroundColor(.black)
                    .padding(.leading, 20)
                Spacer()
            }
            HStack(spacing:-10) {
                Text("Allergies :")
                    .font(.body)
                    .bold()
                    .padding(.leading, 10)
                    .foregroundColor(.black)
                Text(allergies.isEmpty ? "None" : allergies)
                    .font(.body)
                    .foregroundColor(.black)
                    .padding(.leading, 20)
                Spacer()
            }
        }
        .padding(.bottom,5)
        .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

struct ContactInfo: View {
    
    var helpseeker: String
    var body: some View {
        VStack(spacing:5) {
            Image("avatar")
                .resizable()
                .frame(width: 60, height: 60)
                .shadow(radius: 3)
                .padding(.top, 10)
            Text(helpseeker)
                .bold()
               
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

struct TaskTitle: View {
    var taskTitle: String
    var body: some View {
        Text("Title")
            .bold()
            .font(.title2)
            .foregroundColor(Color("Primary"))
        Text(taskTitle)
        
        Divider()
    }
}

struct Address: View {
    var location: String
    var body: some View {
        Text("Address")
            .bold()
            .font(.title2)
            .foregroundColor(Color("Primary"))
        Text(location)
        Divider()
    }
}

struct TimeNeeded: View {
    var time: Date?
    var body: some View {
        Text("Time")
            .bold()
            .font(.title2)
            .foregroundColor(Color("Primary"))
        Text("time")
        Divider()
    }
}

struct TaskDescription: View {
    var desc: String
    var body: some View {
        Text("Description")
            .bold()
            .font(.title2)
            .foregroundColor(Color("Primary"))
        Text(desc)
    }
}



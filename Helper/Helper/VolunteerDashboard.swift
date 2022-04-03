//
//  VolunteerDashboard.swift
//  Helper
//
//  Created by Annie Huynh on 3.4.2022.
//

import SwiftUI

struct VolunteerDashboard: View {
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                
                
                VStack (alignment: .leading){
                    AppBarView()
                    TagLineView()
                        .padding()
                    SearchAndFilter()
                    Text("Available Tasks")
                        .font(.system(size: 24))
                        .padding(.horizontal)
                    Text("10 tasks waiting to be accepted")
                        .font(.system(size: 16))
                        .foregroundColor(Color("Primary"))
                        .fontWeight(.medium)
                        .padding(.horizontal)
                    
                    
                    CategoriesView()
                    Text("Ongoing Tasks")
                        .font(.system(size: 24))
                        .padding(.horizontal)
                    OngoingTaskCard()
                }
            }
        }
    }
}

struct VolunteerDashboard_Previews: PreviewProvider {
    static var previews: some View {
        VolunteerDashboard()
    }
}

struct AppBarView: View {
    var body: some View {
        HStack{
            Button(action: {}){
                Image("menu")
                    .resizable()
                    .padding()
                    .background(.white)
                    .frame(width: 50, height: 50)
                    .cornerRadius(10)
            }
            Spacer()
            Button(action: {}) {
                Image("Avatar-1")
                    .resizable()
                    .padding()
                    .frame(width: 90, height: 90)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal)
    }
}

struct TagLineView: View {
    var body: some View {
        Text("Manage Your Task")
            .font(.system(size: 28))
            .fontWeight(.semibold)
            .foregroundColor(Color("Primary"))
    }
}

struct SearchAndFilter: View {
    @State private var search: String = ""
    var body: some View {
        HStack {
            HStack{
                Image("Search")
                    .resizable()
                    .frame(width: 20, height: 20)
                
                TextField("Search Tasks", text: $search)
                    .background(.white)
            }
            .padding(.all, 20)
            .background(.white)
            .cornerRadius(10)
            
            Button(action: {}) {
                Image("equalizer")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
            }
            
            
        }
        .padding(.horizontal)
    }
}

struct CategoriesView: View {
    var body: some View {
        HStack{
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(width: 120, height: 150)
                VStack(alignment: .leading){
                    Text("Grocery")
                        .font(.headline)
                        .fontWeight(.medium)
                        .padding(.top,20)
                    Text("3 tasks")
                        .font(.subheadline)
                    
                    Image("groceries image")
                        .resizable()
                        .frame(width: 110, height: 90)
                        .padding(.bottom)
                }
                
                
            }
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(width: 120, height: 150)
                VStack(alignment: .leading){
                    Text("Grocery")
                        .font(.headline)
                        .fontWeight(.medium)
                        .padding(.top,20)
                    Text("3 tasks")
                        .font(.subheadline)
                    Image("delivery image")
                        .resizable()
                        .frame(width: 110, height: 90)
                        .padding(.bottom)
                }
                
            }
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(width: 120, height: 150)
                VStack(alignment: .leading){
                    Text("Others")
                        .font(.headline)
                        .fontWeight(.medium)
                        .padding(.top,20)
                    Text("4 tasks")
                        .font(.subheadline)
                    Image("helping image")
                        .resizable()
                        .frame(width: 110, height: 90)
                        .padding(.bottom)
                }
                
            }
            
            
        }
        .padding()
    }
}

struct OngoingTaskCard: View {
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(width: 330, height: 150)
                VStack(alignment: .leading, spacing: 10){
                    HStack(spacing: 130){
                        Text("Grocery Shopping")
                            .font(.headline)
                            .fontWeight(.medium)
                        
                        Text("Today")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Primary"))
                        
                    }
                    HStack(spacing: 100){
                        Label("Mr. John Doe", systemImage: "person")
                        
                        Label("Helsinki", systemImage: "mappin")
                        
                    }
                    Text("Instructions: leave at door")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                    HStack(spacing:80){
                        Label("2:30PM - 3:00PM", systemImage: "clock")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                        Button(action: {}) {
                            Text("View Task")
                                .font(.subheadline)
                                .frame(width: 90, height: 30)
                                .background(Color("Primary"))
                                .foregroundColor(.white)
                                .cornerRadius(6)
                        }
                    }
                    
                }
                
            }
            
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(width: 330, height: 150)
                VStack(alignment: .leading, spacing: 10){
                    HStack(spacing: 130){
                        Text("Grocery Shopping")
                            .font(.headline)
                            .fontWeight(.medium)
                        
                        Text("Today")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Primary"))
                        
                    }
                    HStack(spacing: 100){
                        Label("Mr. John Doe", systemImage: "person")
                        
                        Label("Helsinki", systemImage: "mappin")
                        
                    }
                    Text("Instructions: leave at door")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                    HStack(spacing:80){
                        Label("2:30PM - 3:00PM", systemImage: "clock")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                        Button(action: {}) {
                            Text("View Task")
                                .font(.subheadline)
                                .frame(width: 90, height: 30)
                                .background(Color("Primary"))
                                .foregroundColor(.white)
                                .cornerRadius(6)
                        }
                    }
                    
                }
            }
            .padding()
        }
        .padding()
    }
}


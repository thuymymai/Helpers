//
//  VolunteerDashboard.swift
//  Helper
//
//  Created by Annie Huynh on 3.4.2022.
//

import SwiftUI

struct VolunteerDashboard: View {
    //    let categories: [TaskCategories]
    var body: some View {
        NavigationView{
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
                            .padding(.horizontal, 30)
                        Text("10 tasks waiting to be accepted")
                            .font(.system(size: 16))
                            .foregroundColor(Color("Primary"))
                            .fontWeight(.medium)
                            .padding(.horizontal,30)
                        //ForEach(categories) {category in
                        //                        NavigationLink(destination: AvailableTasksView(category: category)) {
                        //                            CategoriesView(category: category)
                        //
                        //                        }
                        HStack(alignment:.center) {
                            NavigationLink(destination: AvailableTasksView()) {
                                CategoriesView(categoryName: "Grocery", numberOfTasks: "3 Tasks", ImageName: "groceries image")
                                   
                               
                            }
                            NavigationLink(destination: AvailableTasksView()) {
                                CategoriesView(categoryName: "Grocery", numberOfTasks: "3 Tasks", ImageName: "groceries image")
                                   
                               
                            }
                            NavigationLink(destination: AvailableTasksView()) {
                                CategoriesView(categoryName: "Grocery", numberOfTasks: "3 Tasks", ImageName: "groceries image")
                                   
                               
                            }
                        }.padding(.leading,30)
                        Text("Ongoing Tasks")
                            .font(.system(size: 24))
                            .padding(.horizontal, 30)
                        OngoingTaskCard()
                    }
                } .padding()
                
            }
            .navigationBarHidden(true)
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
                    .frame(width: 85, height: 85)
                    .shadow(radius: 5)
                
            }
        }
        .padding(.horizontal, 30)
    }
}

struct TagLineView: View {
    var body: some View {
        Text("Hi User\nManage Your Task")
            .font(.system(size: 28))
            .fontWeight(.semibold)
            .foregroundColor(Color("Primary"))
            .padding(.horizontal,15)
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
        .padding(.horizontal, 30)
    }
}

struct CategoriesView: View {
    var categoryName: String
    var numberOfTasks: String
    var ImageName: String
    var body: some View {
       

                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .frame(width: 110, height: 140)
                        .shadow(radius: 5)
                    
                    VStack(alignment: .leading){
                        Text(categoryName)
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                            .padding(.top,25)
                        Text(numberOfTasks)
                            .font(.subheadline)
                            .foregroundColor(.primary)
                        Image(ImageName)
                            .resizable()
                            .frame(width: 100, height: 75,alignment: .center)
                            .padding(.bottom,20)
                    }
                }
          
        
    }
}

struct OngoingTaskCard: View {
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(width: 330, height: 150)
                    .shadow(radius: 5)
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
                
            }.padding(.horizontal, 20)
    
        }
        .padding()
    }
}


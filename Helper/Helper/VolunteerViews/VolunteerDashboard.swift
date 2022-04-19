//
//  VolunteerDashboard.swift
//  Helper
//
//  Created by Annie Huynh on 3.4.2022.
//

import SwiftUI


struct VolunteerDashboard: View {
    @State private var isLogoutMenuClicked = false
    @State private var isFirstAidClicked = false
    @State private var isLinkActive: Bool = false
    
    @ViewBuilder
    func chooseDestination()-> some View {
        if (isFirstAidClicked) { FirstAid().navigationBarHidden(true)
            
        }else if (isLogoutMenuClicked){
            LandingPage().navigationBarHidden(true)
        }else {
            VolunteerProfile().navigationBarHidden(true)
        }
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            NavigationView{
                ZStack{
                    Color("Background")
                        .edgesIgnoringSafeArea(.all)
                    ScrollView{
                        VStack (alignment: .leading){
                            TagLineView().padding(.top)
                            SearchAndFilter()
                            VStack(alignment: .leading, spacing: 5){
                                Text("Available Tasks")
                                    .font(.system(size: 24))
                                Text("10 tasks waiting to be accepted")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color("Primary"))
                                    .fontWeight(.medium)
                            }.padding(.top, 55)
                            HStack(alignment:.center, spacing: 10) {
                                NavigationLink(destination: AvailableTasksView()) {
                                    CategoriesView(categoryName: "Grocery", numberOfTasks: "3 Tasks", ImageName: "groceries image")
                                }
                                NavigationLink(destination: AvailableTasksView()) {
                                    CategoriesView(categoryName: "Delivery", numberOfTasks: "3 Tasks", ImageName: "delivery image")
                                }
                                NavigationLink(destination: AvailableTasksView()) {
                                    CategoriesView(categoryName: "Others", numberOfTasks: "4 Tasks", ImageName: "helping image")
                                }
                            }
                            
                            Text("Ongoing Tasks")
                                .font(.system(size: 24))
                            OngoingTaskCard().padding(.top,-20)
                        }.padding(.horizontal)
                        
                    } .padding(.horizontal)
                }
                .navigationBarTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .background(
                    NavigationLink(destination: chooseDestination(), isActive: $isLinkActive) {
                        EmptyView()
                    }
                    
                )
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Button(action: {
                                
                                self.isLinkActive = true
                                self.isFirstAidClicked = true
                            }, label: {
                                Label(title: {Text("First Aid Manual")}, icon: {Image(systemName: "info")})
                            })
                            Button(action:{
                                
                                self.isLinkActive = true
                                self.isLogoutMenuClicked = true
                            }, label: {
                                Label(title: {Text("Log Out")}, icon: {Image(systemName: "rectangle.portrait.and.arrow.right")})
                            })
                            
                        }
                    label: {
                        Label("Menu", systemImage: "line.horizontal.3")
                    }
                    }
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

struct TagLineView: View {
    var body: some View {
        
        HStack {
            Text("Hi User\nManage Your Tasks")
                .font(.system(size: 28))
                .fontWeight(.semibold)
                .foregroundColor(Color("Primary"))
            Spacer()
            NavigationLink(destination: VolunteerProfile()
                           
            ) {
                Image("Avatar-1")
                    .resizable()
                    .padding()
                    .frame(width: 85, height: 85)
                    .shadow(radius: 5)
            }
        }
    }
}

struct SearchAndFilter: View {
    @State private var search: String = ""
    var body: some View {
        GeometryReader { geometry in
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
        }
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
        GeometryReader { geometry in
            
            VStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .shadow(radius: 5)
                        .frame(width: geometry.size.width * 0.98, height: geometry.size.height * 15, alignment: .center)
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
                            NavigationLink(destination: TaskDetailView()){
                                Text("View Task")
                                    .font(.subheadline)
                                    .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 3)
                                    .background(Color("Primary"))
                                    .foregroundColor(.white)
                                    .cornerRadius(6)
                            }
                        }
                    }
                }
            }.padding(.vertical, 30)
        }
    }
}


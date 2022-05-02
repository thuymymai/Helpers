//
//  VolunteerDashboard.swift
//  Helper
//
//  Created by Annie Huynh on 3.4.2022.
//

import SwiftUI
import CoreData

struct VolunteerDashboard: View {
    // volunteer user name
    @Binding var volunteerName: String
    
    // fetch data from core
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.title, ascending: true)]) var taskResults: FetchedResults<Task>
    
    // task related details
    @State var userInfo: [User]  = []
    @State var taskInfo: [Task] = []
    @State var availableTasks: [Task] = []
    @State var assistance: [Task] = []
    @State var transport: [Task] = []
    @State var others: [Task] = []
    
    // get task of current user
    func getTaskInfo() {
        DispatchQueue.main.async {
            self.userInfo = results.filter{$0.fullname?.lowercased() == volunteerName.lowercased() }
            if(userInfo.count > 0){
                self.taskInfo = taskResults.filter{$0.volunteer == userInfo[0].userId && $0.status == 0}
            }
        }
    }
    // get helpseeker
    func getHelpseeker(task: Task) -> User {
        for user in results {
            if (user.userId == task.helpseeker) {
                return user
            }
        }
        return User()
    }
    
    // sort task by category
    func sortCategory() {
        DispatchQueue.main.async {
            self.availableTasks = taskResults.filter{$0.volunteer == 0}
            self.assistance = availableTasks.filter{$0.category?.lowercased() == "personal assistant" || $0.category?.lowercased() == "housework"}
            self.transport = availableTasks.filter{$0.category?.lowercased() == "transportation" || $0.category?.lowercased() == "delivery" }
            self.others = availableTasks.filter{$0.category?.lowercased() != "personal assistant" && $0.category?.lowercased() != "transportation" && $0.category?.lowercased() != "delivery" && $0.category?.lowercased() != "housework"}
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                ZStack{
                    Color("Background")
                    VStack(spacing:20) {
                        HStack {
                            if (Locale.preferredLanguages[0] == "fi") {
                                Text("Hei \(volunteerName)\n")
                                    .font(.system(size: 28))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("Primary"))
                                + Text("Manage Your Tasks")
                                    .font(.system(size: 28))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("Primary"))
                            } else {
                                Text("Hi \(volunteerName)\n")
                                    .font(.system(size: 28))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("Primary"))
                                + Text("Manage Your Tasks")
                                    .font(.system(size: 28))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("Primary"))
                            }
                            Spacer()
                            NavigationLink(destination: VolunteerProfile(volunteerName: $volunteerName)) {
                                Image("volunteer")
                                    .resizable()
                                    .padding()
                                    .frame(width: 85, height: 85)
                                    .shadow(radius: 5)
                            }
                        }
                        .padding(.top,10)
                        .padding(.horizontal,15)
                        
                        ImageSlideShow()
                            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.25)
                        
                        VStack(alignment: .leading, spacing: 5){
                            HStack {
                                Text("Available Tasks")
                                    .font(.system(size: 24))
                                Spacer()
                                NavigationLink(destination: CategoryTaskView(category: $availableTasks, userInfo: $userInfo, volunteerName: $volunteerName)) {
                                    Text("View All")
                                        .underline()
                                        .bold()
                                        .font(.subheadline)
                                        .foregroundColor(Color("Primary"))
                                        .cornerRadius(6)
                                }
                            }
                            if (Locale.preferredLanguages[0] == "fi") {
                                Text("\(availableTasks.count) hyväksymistä odottavia tehtäviä")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color("Primary"))
                                    .fontWeight(.medium)
                            } else {
                                Text("\(availableTasks.count) tasks waiting to be accepted")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color("Primary"))
                                    .fontWeight(.medium)
                            }
                        }
                        .padding(.horizontal, 15)
                        
                        HStack(spacing: 10) {
                            let _ = sortCategory()
                            
                            NavigationLink(destination: CategoryTaskView(category: $assistance, userInfo: $userInfo, volunteerName: $volunteerName)) {
                                if (Locale.preferredLanguages[0] == "fi") {
                                    CategoriesView(categoryName: "Apu", numberOfTasks: "\(assistance.count) Tehtävät", ImageName: "helping image")
                                } else {
                                    CategoriesView(categoryName: "Assistance", numberOfTasks: "\(assistance.count) Tasks", ImageName: "helping image")
                                }
                            }
                            NavigationLink(destination: CategoryTaskView(category: $transport, userInfo: $userInfo, volunteerName: $volunteerName)) {
                                if (Locale.preferredLanguages[0] == "fi") {
                                    CategoriesView(categoryName: "Kuljetus", numberOfTasks: "\(transport.count) Tehtävät", ImageName: "delivery image")
                                } else {
                                    CategoriesView(categoryName: "Transport", numberOfTasks: "\(transport.count) Tasks", ImageName: "delivery image")
                                }
                            }
                            
                            NavigationLink(destination: CategoryTaskView(category: $others, userInfo: $userInfo, volunteerName: $volunteerName)) {
                                if (Locale.preferredLanguages[0] == "fi") {
                                    CategoriesView(categoryName: "Muut", numberOfTasks: "\(others.count) Tehtävät", ImageName: "groceries image")
                                } else {
                                    CategoriesView(categoryName: "Others", numberOfTasks: "\(others.count) Tasks", ImageName: "groceries image")
                                }
                            }
                        } // close HSTack
                        .padding(.horizontal)
                        
                        Text("Ongoing Tasks")
                            .font(.system(size: 24))
                            .padding(.top, -10)
                            .offset(x:-110)
                            .padding(.bottom,30)
                        
                        VStack(spacing: 20) {
                            let _ = getTaskInfo()
                            if (taskInfo.count > 0) {
                                ForEach(taskInfo) { task in
                                    let helpseeker  = getHelpseeker(task: task)
                                    TaskCard(currentTask: task, helpseeker: helpseeker, userInfo: userInfo, volunteerName: volunteerName)
                                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.23,alignment: .top)
                                        .background(.white)
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                        .padding(.bottom,10)
                                }
                            } else {
                                ZStack{
                                    Color("Background")
                                }
                                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.23,alignment: .top)
                                .background(Color("Background"))
                            }
                        }
                    }.padding(.horizontal, 10)
                }// close ZStack
            } // close Scrollview
        }// close geometryreader
    }
}


struct VolunteerDashboard_Previews: PreviewProvider {
    static var previews: some View {
        VolunteerDashboard(volunteerName: .constant(""))
    }
}


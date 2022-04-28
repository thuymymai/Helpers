//
//  VolunteerDashboard.swift
//  Helper
//
//  Created by Annie Huynh on 3.4.2022.
//

import SwiftUI
import Combine

struct VolunteerDashboard: View {
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
            self.userInfo = results.filter{$0.fullname == volunteerName }
            if(userInfo.count > 0){
                self.taskInfo = taskResults.filter{$0.volunteer == userInfo[0].userId &&  $0.status == 0}
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
    func sortCategory(category: String) {
        DispatchQueue.main.async {
            self.availableTasks = taskResults.filter{$0.volunteer == 0}
            if (category == "Assistance"){
                self.assistance = availableTasks.filter{$0.category == "personal assistant" || $0.category == "housework"}
            }else if (category == "Transport"){
                self.transport = availableTasks.filter{$0.category == "transportation" || $0.category == "delivery" }
            }else {
                self.others = availableTasks.filter{$0.category != "personal assistant" && $0.category != "transportation"
                    && $0.category != "delivery" && $0.category != "housework"
                }
            }
        }
    }
    var body: some View {
        GeometryReader { geometry in
            Color("Background")
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing:20) {
                    HStack {
                        Text("Hi \(volunteerName)\n")
                            .font(.system(size: 28))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Primary"))
                        + Text("Manage Your Tasks")
                            .font(.system(size: 28))
                            .fontWeight(.regular)
                            .foregroundColor(Color("Primary"))
                        Spacer()
                        NavigationLink(destination: VolunteerProfile(volunteerName: $volunteerName)
                        ) {
                            Image("volunteer")
                                .resizable()
                                .padding()
                                .frame(width: 85, height: 85)
                                .shadow(radius: 5)
                        }
                    }.padding(.top,10)
                        .padding(.horizontal,15)
                    
                    ImageSlideShow()
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.25)
                    
                    VStack(alignment: .leading, spacing: 5){
                        HStack {
                            Text("Available Tasks")
                                .font(.system(size: 24))
                            Spacer()
                            NavigationLink(destination: AllTasksView(userInfo: $userInfo, taskInfo: $taskInfo, availableTasks: $availableTasks, volunteerName: $volunteerName)){
                                Text("View All")
                                    .underline()
                                    .bold()
                                    .font(.subheadline)
                                    .foregroundColor(Color("Primary"))
                                    .cornerRadius(6)
                            }
                        }
                        Text("\(availableTasks.count) tasks waiting to be accepted")
                            .font(.subheadline)
                            .foregroundColor(Color("Primary"))
                            .fontWeight(.medium)
                    }.padding(.horizontal, 15)
                    
                    HStack(spacing: 10) {
                        let _ = sortCategory(category: "Assistance")
                        let _ = sortCategory(category: "Transport")
                        let _ = sortCategory(category: "Others")
                        
                        NavigationLink(destination: AssistanceTasksView(assistance: $assistance, userInfo: $userInfo, taskInfo: $taskInfo, availableTasks: $availableTasks, volunteerName: $volunteerName)) {
                            CategoriesView(categoryName: "Assistance", numberOfTasks: "\(assistance.count) Tasks", ImageName: "helping image")
                        }
                        NavigationLink(destination: TransportTasksView(transport: $transport,userInfo: $userInfo, taskInfo: $taskInfo, availableTasks: $availableTasks,volunteerName: $volunteerName)) {
                            CategoriesView(categoryName: "Transport", numberOfTasks: "\(transport.count) Tasks", ImageName: "delivery image")
                        }

                        NavigationLink(destination: OthersTasksView(others: $others,userInfo: $userInfo, taskInfo: $taskInfo, availableTasks: $availableTasks,volunteerName: $volunteerName)) {
                            CategoriesView(categoryName: "Others", numberOfTasks: "\(others.count) Tasks", ImageName: "groceries image")
                        }
                    } // close HSTack
                    .padding(.horizontal)
                    Text("Ongoing Tasks")
                        .font(.system(size: 24))
                        .padding(.top, -10)
                        .offset(x:-105)
                        .padding(.bottom,30)
                }.padding(.horizontal, 10)
                    VStack(spacing: 20) {
                        let _ = getTaskInfo()
                        if(taskInfo.count > 0) {
                            ForEach(taskInfo) { task in
                                let helpseeker  = getHelpseeker(task: task)
                                TaskCard(currentTask: task, helpseeker: helpseeker, userInfo: userInfo, volunteerName: volunteerName)
                                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.23,alignment: .top)
                                                               .background(.white)
                                                               .cornerRadius(10)
                                                               .shadow(radius: 5)
                                .padding(.bottom,10)
                            }
                        }
                    //}.padding(.top, -20)
                }.padding(.horizontal) // close big Vstack
            } // close Scrollview
        }// close geometryreader
        .padding(.bottom, 10)
//        .background(Color("Background").edgesIgnoringSafeArea(.top))
    }
}


struct VolunteerDashboard_Previews: PreviewProvider {
    static var previews: some View {
        VolunteerDashboard(volunteerName: .constant(""))
    }
}


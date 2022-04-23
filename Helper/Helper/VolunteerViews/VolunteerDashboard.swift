//
//  VolunteerDashboard.swift
//  Helper
//
//  Created by Annie Huynh on 3.4.2022.
//

import SwiftUI


struct VolunteerDashboard: View {
    @Binding var volunteerName: String
    
    // fetch data from core
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.title, ascending: true)]) var taskResults: FetchedResults<Task>
    
    // task related details
    @State private var userInfo: [User]  = []
    @State private var taskInfo: [Task] = []
    
    func getTaskInfo() -> [User] {
        var taskSenders: [User] = []
        
        // current user
        self.userInfo = results.filter{$0.fullname == volunteerName }
        
        if(userInfo.count > 0){
            self.taskInfo = taskResults.filter{$0.volunteer == userInfo[0].userId}
        }
        // get task sender's name
        for task in taskInfo {
            taskSenders.append(contentsOf:(results.filter{$0.userId == task.helpseeker}))
//            for user in results {
//                if (user.userId == task.helpseeker) {
//                    taskSenders1.append(user)
//                }
//            }
            
       }
        return taskSenders
    }
    
    func getHelpseeker(helpseekers: [User], task: Task) -> User {
        var helpseeker = User()
        for user in helpseekers {
            if (user.userId == task.helpseeker) {
                helpseeker = user
            }
        }
        return helpseeker
    }
    
  
    var body: some View {
        
        GeometryReader { geometry in
            
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
                        NavigationLink(destination: VolunteerProfile()
                                       
                        ) {
                            Image("Avatar-1")
                                .resizable()
                                .padding()
                                .frame(width: 85, height: 85)
                                .shadow(radius: 5)
                        }
                    }
                    SearchAndFilter()
                    VStack(alignment: .leading, spacing: 5){
                        Text("Available Tasks")
                            .font(.system(size: 24))
                        Text("\(taskResults.count) tasks waiting to be accepted")
                            .font(.system(size: 16))
                            .foregroundColor(Color("Primary"))
                            .fontWeight(.medium)
                    }.padding(.top,50)
                        .offset(x: -55)
                    HStack(spacing: 10) {
                        NavigationLink(destination: AvailableTasksView()) {
                            CategoriesView(categoryName: "Grocery", numberOfTasks: "3 Tasks", ImageName: "groceries image")
                        }
                        NavigationLink(destination: AvailableTasksView()) {
                            CategoriesView(categoryName: "Delivery", numberOfTasks: "3 Tasks", ImageName: "delivery image")
                        }
                        NavigationLink(destination: AvailableTasksView()) {
                            CategoriesView(categoryName: "Others", numberOfTasks: "4 Tasks", ImageName: "helping image")
                        }
                    } // close HSTack
                    Text("Ongoing Tasks")
                        .font(.system(size: 24))
                        .padding(.top, -10)
                        .offset(x: -95)
                        .padding(.bottom,30)
                    VStack(spacing: 30) {
                        
                        let helpseekers = getTaskInfo()
                        if(taskInfo.count > 0) {
                            ForEach(taskInfo) { task in
                               let helpseeker  = getHelpseeker(helpseekers: helpseekers, task: task)
                               // for user in helpseekers {
//                                    if (user.userId == task.helpseeker) {
//                                        helpseeker = user
//                                    }
                                //}
                                OngoingTaskCard(taskTitle: task.title!, helpseeker: helpseeker.fullname!, location: task.location!, time: task.time!, date: task.time!)
                            }
                        }
                    }.padding(.top, -20)
                }.padding(.horizontal) // close big Vstack
            } // close Scrollview
        }// close geometryreader
        .padding(.bottom, 10)
        .background(Color("Background").edgesIgnoringSafeArea(.top))
    }
}




struct VolunteerDashboard_Previews: PreviewProvider {
    static var previews: some View {
        VolunteerDashboard(volunteerName: .constant(""))
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
    var taskTitle: String
    var helpseeker: String
    var location: String
    var time: Date?
    var date: Date?
    
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(radius: 5)
                .frame(width: 340, height: 150)
            
            VStack(alignment:.leading,spacing:10){
                HStack{
                    Text(taskTitle)
                        .font(.headline)
                        .fontWeight(.semibold)
                    Spacer()
                    Text(time!.formatted(date: .numeric, time: .omitted))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Primary"))
                }.padding(.horizontal)
                
                Label("Sender: \(helpseeker)", systemImage: "person").padding(.horizontal)
                Label("Address: \(location)", systemImage: "mappin").padding(.horizontal)
                
                HStack{
                    
                    Label(time!.formatted(date: .omitted, time: .complete), systemImage: "clock")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                    Spacer()
                    NavigationLink(destination: TaskDetailView()){
                        Text("View Task")
                            .font(.subheadline)
                            .frame(width: 90, height: 30)
                            .background(Color("Primary"))
                            .foregroundColor(.white)
                            .cornerRadius(6)
                    }
                }.padding(.horizontal)
            }
        }
    }
}


//
//  AvailableTasksView.swift
//  Helper
//
//  Created by Annie Huynh on 5.4.2022.
//

import SwiftUI

struct TaskList: View {
    @Binding var helpseekerName: String
    
    @Environment(\.managedObjectContext) var context

    
    // fetching user data from core data
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    
    // fetching task data from core data
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.title, ascending: true)]) var taskResults: FetchedResults<Task>
    
    // task related details
    @State  var userInfo: [User]  = []
    @State var taskInfo: [Task] = []
    
    
    func getTaskInfo() {
        self.userInfo = results.filter{$0.fullname == helpseekerName }
        print("helpseekerName: \(helpseekerName) count: \(helpseekerName.count)")
        print("result count: \(results.count)")
        print("task result count: \(taskResults.count)")
        print("user info \(userInfo.count)")
        
        if(userInfo.count > 0){
            self.taskInfo = taskResults.filter{$0.helpseeker == userInfo[0].userId}
        }
    }
    
    func getVolunteer(task: Task) -> User {
        for user in results {
            if (user.userId == task.volunteer) {
                return user
            }
        }
        return User(context: context)
    }
    
    var body: some View {
//        ProgressView().onAppear(perform: {getTaskInfo()})
        NavigationView {
            ZStack {
                Color("Primary").edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Your tasks")
                        .font(.system(size: 24))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    let _ = print("task info: \(taskInfo.count)")
                    if(taskInfo.count > 0) {
                        ForEach(taskInfo) { task in
                            let _ = print("tasks \(task)")
                            let volunteer  = getVolunteer(task: task)
                            TaskCard1(taskTitle: task.title!, volunteer: volunteer.fullname ?? "Waiting", location: task.location!, time: task.time!, date: task.time!, status: task.status)
                                .frame(width: 330)
                                .background()
                                .cornerRadius(10)
                                .shadow(radius: 10)
                        }
                    }
                }.frame(maxHeight: .infinity, alignment: .leading)
            }.onAppear(perform: {getTaskInfo()})
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct TaskList_Previews: PreviewProvider {
    static var previews: some View {
        TaskList(helpseekerName: .constant(""))
    }
}

struct TaskCard1: View {
    @State var taskTitle: String
    @State var volunteer: String?
    @State var location: String
    @State var time: Date?
    @State var date: Date?
    @State var status: Int16
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text(taskTitle)
                        .font(.headline)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                }
                    Text("Helper: \(volunteer ?? "Waiting")")
                        .font(.subheadline)
                        .fontWeight(.regular)
                HStack {
                    Label(time!.formatted(date: .omitted, time: .complete), systemImage: "clock")
                        .foregroundColor(.secondary)
                    Text("|")
                        .foregroundColor(.secondary)
                    Label("Location: \(location)", systemImage: "mappin")
                        .foregroundColor(.secondary)
                }
            }
            .layoutPriority(100)
            if(volunteer == "Waiting") {
                Text("Pending")
            } else {
            switch(status){
            case 0:
                Text("Ongoing")
                .frame(width: 80)
                .font(.headline)
                .padding(10)
                .background(Color("Primary"))
                .cornerRadius(10)
                .foregroundColor(.white)
            case 1:
                Text("Done")
                .frame(width: 80)
                .font(.headline)
                .padding(10)
                .background(.green)
                .cornerRadius(10)
                .foregroundColor(.white)
            default:
                Text("task")
            }
            }
        }
        .frame(width: 320)
        .padding()
    }
}

//
//  TaskHistoryView.swift
//  Helper
//
//  Created by Annie Huynh on 27.4.2022.
//


import SwiftUI

struct TaskHistoryView: View {
    @Binding var volunteerName: String
    
    @Environment(\.managedObjectContext) var context
    
    // fetching user data from core data
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    
    // fetching task data from core data
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.title, ascending: true)]) var taskResults: FetchedResults<Task>
    
    // task related details
    @State  var userInfo: [User]  = []
    @State var taskInfo: [Task] = []
    
    
    func getTaskInfo() {
        self.userInfo = results.filter{$0.fullname == volunteerName }
        print("volunteer name: \(volunteerName) count: \(volunteerName.count)")
        print("result count: \(results.count)")
        print("task result count: \(taskResults.count)")
        print("user info \(userInfo.count)")
        
        if(userInfo.count > 0){
            self.taskInfo = taskResults.filter{$0.volunteer == userInfo[0].userId}
        }
    }
    
    func getHelpseeker(task: Task) -> User {
        for user in results {
            if (user.userId == task.helpseeker) {
                return user
            }
        }
        return User(context: context)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Color("Primary")
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .center) {
                        
                        let _ = print("task info: \(taskInfo.count)")
                        if(taskInfo.count > 0) {
                            ForEach(taskInfo) { task in
                                let _ = print("tasks \(task)")
                                let helpseeker  = getHelpseeker(task: task)
                                if(task.status == 1){
                                    TaskHistoryCard(taskTitle: task.title!, user: helpseeker.fullname, location: task.location!, time: task.time!, date: task.time!, status: task.status)
                                        .frame(width: geometry.size.width * 0.9)
                                        .background()
                                        .cornerRadius(10)
                                        .shadow(radius: 10)
                                        .padding(.bottom,10)
                                        .offset(y: 30)
                                }
                            }
                        }
                    }
                    
                }.frame(maxHeight: geometry.size.height * 0.97)
            }
            
        }.onAppear(perform: {getTaskInfo()})
    }
}


struct TaskHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        TaskList(helpseekerName: .constant(""))
    }
}


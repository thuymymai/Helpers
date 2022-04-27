//
//  TransportTasks.swift
//  Helper
//
//  Created by Annie Huynh on 25.4.2022.
//

import SwiftUI

struct TransportTasksView: View {
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.title, ascending: true)]) var taskResults: FetchedResults<Task>
    
    //@Binding var volunteerName: String
    
    @Binding var transport: [Task]
    @Binding var userInfo: [User]
    @Binding var taskInfo: [Task]
    @Binding var availableTasks: [Task]
    @Binding var volunteerName: String
//    @Binding var currentTask: Task
//    @Binding var helpseeker: User
//    @State var showAlert: Bool = false
//    @State var isLinkActive = false
  
//
//        @State var taskTitle: String
//        @State var helpseeker: String
//        @State var location: String
//        @State var time: Date?
//        @State var need: String
//        @State var desc: String
//        @State var chronic: String
//        @State var allergies: String
//  
    
    func getHelpseeker(task: Task) -> User {
        for user in results {
            if (user.userId == task.helpseeker) {
                return user
            }
        }
        return User()
    }
    var body: some View {
        GeometryReader{geometry in
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                ZStack{
                    VStack(spacing: 20){
                       TaskCard(userInfo: userInfo, taskInfo:taskInfo, availableTasks:availableTasks,categoryTask: transport,volunteerName: volunteerName)
                            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.25,alignment: .top)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding(.horizontal)
                       
                    }
                }
            }
        }
    }
}

struct TransportTasks_Previews: PreviewProvider {
    static var previews: some View {
        TransportTasksView(transport: .constant([]), userInfo: .constant([]), taskInfo: .constant([]), availableTasks: .constant([]),volunteerName: .constant(""))
    }
}


//
//  AssistanceTasksView.swift
//  Helper
//
//  Created by Annie Huynh on 5.4.2022.
//

import SwiftUI

struct AssistanceTasksView: View {
    
    @Binding var assistance: [Task]
    @Binding var userInfo: [User]
    @Binding var taskInfo: [Task]
    @Binding var availableTasks: [Task]
    @Binding var volunteerName: String
    //    @Binding var currentTask: Task
    //    @Binding var helpseeker: User
    var body: some View {
        GeometryReader{geometry in
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                ZStack{
                    VStack(spacing: 20){
                        TaskCard(userInfo: userInfo, taskInfo:taskInfo, availableTasks:availableTasks,categoryTask: assistance, volunteerName: volunteerName)
                        
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


struct AvailableTasksView_Previews: PreviewProvider {
    static var previews: some View {
        AssistanceTasksView(assistance: .constant([]), userInfo: .constant([]), taskInfo: .constant([]), availableTasks: .constant([]),volunteerName: .constant(""))
        
    }
}

struct TaskCard: View {
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.title, ascending: true)]) var taskResults: FetchedResults<Task>
    
    @Environment(\.managedObjectContext) var context
    
    @State var showAlert: Bool = false
    @State var isLinkActive = false
    @State var userInfo: [User]
    @State var taskInfo: [Task]
    @State var availableTasks: [Task]
    @State var categoryTask: [Task]
    @State var taskId: Int16 = 0
    @State var volunteerName: String
    //    @State var currentTask: Task
    //    @State var helpseeker: User
    func getHelpseeker(task: Task) -> User {
        for user in results {
            if (user.userId == task.helpseeker) {
                return user
            }
        }
        return User()
    }
    
    var body: some View {
        
        ForEach(categoryTask){ task in
            let helpseeker = getHelpseeker(task: task)
            let _ = print("categoryTask \(categoryTask)")
            NavigationLink(destination: TaskDetailView(taskTitle: task.title!, helpseeker: helpseeker.fullname!, location: task.location!,
                                                       time: task.time!, desc: task.desc!, need: helpseeker.need!,
                                                       chronic: helpseeker.chronic!, allergies: helpseeker.allergies!, id: task.id )){
                VStack{
                    HStack{
                        Text(task.title!)
                            .font(.headline)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Text(task.time!.formatted(date: .numeric, time: .omitted))
                            .font(.headline)
                            .foregroundColor(Color("Primary"))
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal,15)
                    .padding(.top)
                    HStack(alignment:.center) {
                        VStack(alignment: .leading, spacing: 10) {
                            Label(helpseeker.fullname!, systemImage: "person")
                                                           .font(.subheadline)
                                                           .foregroundColor(.black)
                            Label(task.location!, systemImage: "mappin")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                            
                            HStack(spacing:-10) {
                                Label("Disabilities: ", systemImage: "figure.roll")
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                                Text(helpseeker.need ?? "Immobilized")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .padding(.leading, 20)
                                Spacer()
                            }
                            
                        }
                        .layoutPriority(100)
                        Spacer()
                        NavigationLink(
                            destination: VolunteersNavBar( volunteerName: $volunteerName)
                                .navigationBarHidden(true), isActive: $isLinkActive) {EmptyView()}
                        Button(action: {
                            self.taskId = task.id
                            showAlert.toggle()
                            
                        })
                        {
                            if(task.status == 0){
                                Text("Accept Task")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .frame(width: 100, height: 30)
                                    .background(.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(6)
                            } else {
                                Text("Done")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .frame(width: 100, height: 30)
                                    .background(.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(6)
                            }
                            
                        }
                        .alert(isPresented: $showAlert, content: {
                            Alert(title: Text("Accept Task"), message: Text("Confirm accepting this task"), primaryButton: .default(Text("OK"), action: {
                                //removeTask(task: task)
                                if(taskId != 0){
                                    let _ = print("modify data")
                                    if let index = taskResults.firstIndex(where: {$0.id == taskId}) {
                                        taskResults[index].volunteer = userInfo[0].userId
                                    }
                                    do {
                                        try context.save()
                                    } catch {
                                        print(error)
                                    }
                                    self.isLinkActive = true
                                }
                            }), secondaryButton: .cancel())
                        })
                    }
                    .padding(.horizontal)
                }
            }
            
        }// close foreach
    }
}


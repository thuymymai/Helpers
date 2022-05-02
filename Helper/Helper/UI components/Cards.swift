//
//  Cards.swift contains the Card components that are used for task display and task history
//  Helper
//
//  Created by Annie Huynh on 28.4.2022.
//

import SwiftUI
import CoreData

struct TaskCard: View {
    // all tasks from core
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.title, ascending: true)]) var taskResults: FetchedResults<Task>
    
    // environment
    @Environment(\.managedObjectContext) var context
    
    @State var showAlert: Bool = false
    @State var taskCompleted: Bool = false
    @State var isLinkActive = false
    @State var taskId: Int16 = 0
    
    @State var currentTask: Task
    @State var helpseeker: User
    @State var userInfo: [User]
    @State var volunteerName: String
    
    var body: some View {
        
        NavigationLink(destination: TaskDetailView(currentTask: $currentTask, helpseeker: $helpseeker)){
            ZStack{
                VStack(alignment:.leading, spacing:10){
                    HStack{
                        Text(currentTask.title!)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        Spacer()
                        Text(currentTask.time!.formatted(date: .numeric, time: .omitted))
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Primary"))
                    }
                    .padding(.horizontal,20)
                    
                    Label("\(helpseeker.fullname!)", systemImage: "person")
                        .padding(.horizontal,20)
                        .foregroundColor(.black)
                    Label("\(currentTask.location!)", systemImage: "mappin")
                        .padding(.horizontal,20)
                        .foregroundColor(.black)
                    
                    HStack{
                        Label(currentTask.time!.formatted(date: .omitted, time: .complete), systemImage: "clock")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                        Spacer()
                        
                        if(currentTask.volunteer != 0){
                            NavigationLink(
                                destination: VolunteersNavBar( volunteerName: $volunteerName)
                                    .navigationBarHidden(true), isActive: $isLinkActive) {EmptyView()}
                            Button(action: {
                                self.taskId = currentTask.id
                                if(taskId != 0){
                                    if let index = taskResults.firstIndex(where: {$0.id == taskId}) {
                                        taskResults[index].status = 1
                                    }
                                    do {
                                        try context.save()
                                    } catch {
                                        print(error)
                                    }
                                    taskCompleted.toggle()
                                }
                            }) {
                                Text("Mark As Done")
                                    .font(.subheadline)
                                    .frame(width: 135, height: 30)
                                    .background(Color("Primary"))
                                    .foregroundColor(.white)
                                    .cornerRadius(6)
                            }
                            .alert(isPresented: $taskCompleted, content: {
                                Alert(title: Text("Thanks for your help!"), message: Text("Check completed task in history menu"), dismissButton: .default(Text("OK"), action: {self.isLinkActive = true}))
                            })
                        } else {
                            NavigationLink(
                                destination: VolunteersNavBar( volunteerName: $volunteerName)
                                    .navigationBarHidden(true), isActive: $isLinkActive) {EmptyView()}
                            Button(action: {
                                self.taskId = currentTask.id
                                showAlert.toggle()
                            }) {
                                Text("Accept Task")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .frame(width: 130, height: 30)
                                    .background(.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(6)
                            }
                            .alert(isPresented: $showAlert, content: {
                                Alert(title: Text("Accept Task"), message: Text("Confirm accepting this task"), primaryButton: .default(Text("OK"), action: {
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
                    }
                    .padding(.horizontal,20)
                }
            }
            .padding(.vertical,20)
        }// close navigationview
    }
}

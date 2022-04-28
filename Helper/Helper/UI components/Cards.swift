//
//  Cards.swift
//  Helper
//
//  Created by Annie Huynh on 28.4.2022.
//

import SwiftUI


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
    
    
    //@State var currentTask: Task
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
//            NavigationLink(destination: TaskDetailView(currentTask: task)){
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
                            Text("Accept Task")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .frame(width: 100, height: 30)
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
                    .padding(.horizontal)
                }
            }
            
        }// close foreach
    }
}

struct OngoingTaskCard: View {
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.title, ascending: true)]) var taskResults: FetchedResults<Task>
    
    @Environment(\.managedObjectContext) var context
    
    @State var isLinkActive = false

    @State var taskTitle: String
    @State var helpseeker: String
    @State var location: String
    @State var time: Date?
    @State var date: Date?
    @State var desc: String
    @State var need: String
    @State var chronic: String
    @State var allergies: String
    @State var id: Int16
    @State var taskId: Int16 = 0
    @Binding var volunteerName: String

    var userInfo: [User]  = []
    var body: some View {
//        NavigationLink(destination: TaskDetailView(taskTitle: taskTitle, helpseeker: helpseeker, location: location,
//                                                   time: time, desc: desc, need: need,
//                                                   chronic: chronic, allergies: allergies, id: id)){
            
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
                            .foregroundColor(.black)
                        Spacer()
                        Text(time!.formatted(date: .numeric, time: .omitted))
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Primary"))
                    }.padding(.horizontal)
                    Label("\(helpseeker)", systemImage: "person")
                        .padding(.horizontal)
                        .foregroundColor(.black)
                    Label("\(location)", systemImage: "mappin")
                        .padding(.horizontal)
                        .foregroundColor(.black)
                    HStack{
                        Label(time!.formatted(date: .omitted, time: .complete), systemImage: "clock")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                        Spacer()
                        
                        NavigationLink(
                            destination: VolunteersNavBar( volunteerName: $volunteerName)
                                .navigationBarHidden(true), isActive: $isLinkActive) {EmptyView()}
                        Button(action: {
                            self.taskId = id
                            if(taskId != 0){
                                if let index = taskResults.firstIndex(where: {$0.id == taskId}) {
                                    taskResults[index].status = 1
                                }
                                do {
                                    try context.save()
                                } catch {
                                    print(error)
                                }
                            }
                            self.isLinkActive = true
                            
                        })
                        {
                            Text("Mark As Done")
                                .font(.subheadline)
                                .frame(width: 110, height: 30)
                                .background(Color("Primary"))
                                .foregroundColor(.white)
                                .cornerRadius(6)
                        }
                        //                        .alert(isPresented: $showAlert, content: {
                        //                            Alert(title: Text("Completed!"), message: Text("Check your task history"), dismissButton: .default(Text("OK")))
                        //                        })
                        
                    }
                    .padding(.horizontal)
                    .padding(.bottom,5)
            //    }
            }
        }
    }
}

struct TaskHistoryCard: View {
    @State var taskTitle: String
    @State var user: String?
    @State var location: String
    @State var time: Date?
    @State var date: Date?
    @State var status: Int16
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                VStack(alignment: .leading, spacing:10) {
                    Text(taskTitle)
                        .font(.headline)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                    Label(user ?? "No volunteer assigned", systemImage: "person")
                        .font(.subheadline)
                        .foregroundColor(.black)
                }
                Spacer()
                if(user == "No volunteer assigned") {
                    Text("Pending")
                        .frame(width: 80)
                        .font(.headline)
                        .padding(10)
                        .background(.orange)
                        .cornerRadius(10)
                        .foregroundColor(.white)
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
            }.padding(.horizontal)
            Label(time!.formatted(date: .omitted, time: .complete), systemImage: "clock")
                .font(.subheadline)
                .foregroundColor(.black)
                .padding(.horizontal)
            Label("Location: \(location)", systemImage: "mappin")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
        }
        .padding(.vertical)
        .layoutPriority(100)
    }
}

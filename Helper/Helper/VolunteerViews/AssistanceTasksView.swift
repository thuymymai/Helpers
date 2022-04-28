//
//  AssistanceTasksView.swift
//  Helper
//
//  Created by Annie Huynh on 5.4.2022.
//

import SwiftUI

struct AssistanceTasksView: View {
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.title, ascending: true)]) var taskResults: FetchedResults<Task>
    @Binding var assistance: [Task]
    
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
                        ForEach(assistance){task in
                            let helpseeker = getHelpseeker(task: task)
                            TaskCard(volunteer: task.volunteer,
                                taskTitle: task.title!, helpseeker: helpseeker.fullname!,  location: task.location!,
                                     time: task.time!, need: helpseeker.need!,
                                     desc: task.desc!, chronic: helpseeker.chronic!, allergies: helpseeker.allergies!)
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
}


struct AvailableTasksView_Previews: PreviewProvider {
    static var previews: some View {
        AssistanceTasksView(assistance: .constant([]))
    }
}

struct TaskCard: View {
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.title, ascending: true)]) var taskResults: FetchedResults<Task>
    @State var volunteer: Int16

    @State var showAlert: Bool = false
    @State var taskTitle: String
    @State var helpseeker: String
    @State var location: String
    @State var time: Date?
    @State var need: String
    @State var desc: String
    @State var chronic: String
    @State var allergies: String
    @State var userInfo: [User]  = []
    @State var currentTasks: [Task] = []
    @State var availableTasks: [Task] = []
    
    func getTaskInfo() {
        self.availableTasks = taskResults.filter{$0.volunteer == 0}
        self.userInfo = results.filter{$0.userId == volunteer }
        if(userInfo.count > 0){
            self.currentTasks = taskResults.filter{$0.volunteer == userInfo[0].userId}

            for task in availableTasks {
//                currentTasks.append(contentsOf:(availableTasks.filter{$0.id == task.helpseeker}))
                currentTasks.append(task)

            }
            //self.currentTasks = taskResults.filter{$0.volunteer == userInfo[0].userId}
        }
        
        print("user \(userInfo)")
        print("count tasks \(currentTasks.count)")
        print("current tasks \(currentTasks)")
    }
    var body: some View {
        
        NavigationLink(destination: TaskDetailView(taskTitle: $taskTitle, helpseeker: $helpseeker, location: $location,
                                                   time: $time, desc: $desc, need: $need,
                                                   chronic: $chronic, allergies: $allergies)){
            VStack{
                HStack{
                    Text(taskTitle)
                        .font(.headline)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Text(time!.formatted(date: .numeric, time: .omitted))
                        .font(.headline)
                        .foregroundColor(Color("Primary"))
                        .fontWeight(.semibold)
                }
                .padding(.horizontal,15)
                .padding(.top,10)
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Label(helpseeker, systemImage: "person")
                            .font(.subheadline)
                            .foregroundColor(.black)
                        Label(location, systemImage: "mappin")
                            .foregroundColor(.primary)
                        HStack(spacing:-10) {
                            Image(systemName: "figure.roll").foregroundColor(.primary)
                            Text("Diability :")
                                .font(.body)
                                .foregroundColor(.primary)
                                .padding(.leading, 20)
                            Text(need.isEmpty ? "wheelchair" : need)
                                .font(.body)
                                .foregroundColor(.black)
                                .padding(.leading, 20)
                            Spacer()
                        }.padding(.bottom,5)
                        
                    }
                    .layoutPriority(100)
                    Spacer()
                    Button(action: {
                        showAlert.toggle()
                        getTaskInfo()
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
                            print("Confirmed")
                        }), secondaryButton: .cancel())
                    })
                }
                .padding(.horizontal)
            }
        }
    }
}


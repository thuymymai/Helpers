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
    // @State var taskStatus: Int16
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
                        .padding(.horizontal,10)
                    
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
                                    .font(.system(size: 14))
                                    .foregroundColor(Color("Primary"))
                                    .cornerRadius(6)
                            }
                        }
                        Text("\(availableTasks.count) tasks waiting to be accepted")
                            .font(.system(size: 16))
                            .foregroundColor(Color("Primary"))
                            .fontWeight(.medium)
                    }.padding(.horizontal, 5)
                    
                    HStack(spacing: 10) {
                        let _ = sortCategory(category: "Assistance")
                        let _ = sortCategory(category: "Transport")
                        let _ = sortCategory(category: "Others")
                        //let _ = getTaskInfo()
                        
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
                    Text("Ongoing Tasks")
                        .font(.system(size: 24))
                        .padding(.top, -10)
                        .offset(x: -95)
                        .padding(.bottom,30)
                    VStack(spacing: 20) {
                        let _ = getTaskInfo()
                        if(taskInfo.count > 0) {
                            ForEach(taskInfo) { task in
                                let helpseeker  = getHelpseeker(task: task)
                                OngoingTaskCard(taskTitle: task.title!, helpseeker: helpseeker.fullname! , location: task.location!,
                                                time: task.time!, date: task.time!, desc: task.desc!,
                                                need: helpseeker.need!, chronic: helpseeker.chronic!, allergies: helpseeker.allergies!, id: task.id
                                )
                                //                                OngoingTaskCard(currentTask: task, helpseeker: helpseeker, userInfo: userInfo)
                                .padding(.bottom,10)
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

struct ImageSlideShow: View{
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    @State private var currentIndex = 0
    
    var body: some View{
        GeometryReader{ geometry in
            TabView(selection: $currentIndex){
                ForEach(0..<4){image in
                    Image("\(image)")
                        .resizable()
                        .scaledToFill()
                        .overlay(Color.black.opacity(0.06))
                        .tag(image)
                }
            }.tabViewStyle(PageTabViewStyle())
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onReceive(timer, perform: {_ in
                    withAnimation{
                        currentIndex = currentIndex < 4 ? currentIndex + 1 :0
                        
                    }
                })
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
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.title, ascending: true)]) var taskResults: FetchedResults<Task>
    @Environment(\.managedObjectContext) var context
    @State var refresh: Bool = false
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
    var userInfo: [User]  = []
    var body: some View {
        NavigationLink(destination: TaskDetailView(taskTitle: taskTitle, helpseeker: helpseeker, location: location,
                                                   time: time, desc: desc, need: need,
                                                   chronic: chronic, allergies: allergies, id: id)){
            
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
                        })
                        {
                            Text("Mark As Done")
                                .font(.subheadline)
                                .frame(width: 110, height: 30)
                                .background(Color("Primary"))
                                .foregroundColor(.white)
                                .cornerRadius(6)
                        }
                    }
                    .padding(.bottom,5)
                }
            }
        }
    }
}

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
    @State var assistance: [Task] = []
    @State var transport: [Task] = []
    @State var others: [Task] = []
    
    // get task of current user
    func getTaskInfo() {
        self.userInfo = results.filter{$0.fullname == volunteerName }
        if(userInfo.count > 0){
            self.taskInfo = taskResults.filter{$0.volunteer == userInfo[0].userId}
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
        if (category == "Assistance"){
            self.assistance = taskResults.filter{$0.category == "Personal assistant" || $0.category == "Housework"}
        }else if (category == "Transport"){
            self.transport = taskResults.filter{$0.category == "Transportation" || $0.category == "Delivery" }
        }else {
            self.others = taskResults.filter{$0.category != "Personal assistant" && $0.category != "Transportation"
                && $0.category != "Delivery" && $0.category != "Housework"
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
                            Image("Avatar-1")
                                .resizable()
                                .padding()
                                .frame(width: 85, height: 85)
                                .shadow(radius: 5)
                        }
                    }.padding(.top,10)
                
                    ImageSlideShow()
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.25)
           
                        VStack(alignment: .leading, spacing: 5){
                            HStack {
                                Text("Available Tasks")
                                    .font(.system(size: 24))
                                Spacer()
                                NavigationLink(destination: AllTasksView()){
                                    Text("View All")
                                        .underline()
                                        .bold()
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("Primary"))
                                        .cornerRadius(6)
                                }
                            }
                            Text("\(taskResults.count) tasks waiting to be accepted")
                                .font(.system(size: 16))
                                .foregroundColor(Color("Primary"))
                                .fontWeight(.medium)
                        }.padding(.horizontal, 5)

                    HStack(spacing: 10) {
                        let _ = sortCategory(category: "Assistance")
                        let _ = sortCategory(category: "Transport")
                        let _ = sortCategory(category: "Others")
                        NavigationLink(destination: AssistanceTasksView(assistance: $assistance)) {
                            CategoriesView(categoryName: "Assistance", numberOfTasks: "\(assistance.count) Tasks", ImageName: "helping image")
                        }
                        NavigationLink(destination: TransportTasksView(transport: $transport)) {
                            CategoriesView(categoryName: "Transport", numberOfTasks: "\(transport.count) Tasks", ImageName: "delivery image")
                        }
                        NavigationLink(destination: OthersTasksView(others: $others)) {
                            CategoriesView(categoryName: "Others", numberOfTasks: "\(others.count) Tasks", ImageName: "groceries image")
                        }
                    } // close HSTack
                    Text("Ongoing Tasks")
                        .font(.system(size: 24))
                        .padding(.top, -10)
                        .offset(x: -95)
                        .padding(.bottom,30)
                    VStack(spacing: 30) {
                        
                        let _ = getTaskInfo()
                        if(taskInfo.count > 0) {
                            ForEach(taskInfo) { task in
                                let helpseeker  = getHelpseeker(task: task)
                                OngoingTaskCard(taskTitle: task.title!, helpseeker: helpseeker.fullname! , location: task.location!,
                                                time: task.time!, date: task.time!, desc: task.desc!,
                                                need: helpseeker.need!, chronic: helpseeker.chronic!, allergies: helpseeker.allergies!)
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
                        .overlay(Color.black.opacity(0.08))
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
    @State var taskTitle: String
    @State var helpseeker: String
    @State var location: String
    @State var time: Date?
    @State var date: Date?
    @State var desc: String
    @State var need: String
    @State var chronic: String
    @State var allergies: String
    
    
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
                    NavigationLink(destination: TaskDetailView(taskTitle: $taskTitle, helpseeker: $helpseeker, location: $location,
                                                               time: $time, desc: $desc, need: $need,
                                                               chronic: $chronic, allergies: $allergies)){
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


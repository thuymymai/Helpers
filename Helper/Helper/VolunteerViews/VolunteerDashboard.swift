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
    @State private var taskSender: [User]  = []
    @State private var taskInfo: [Task] = []
 
    
    func getTaskInfo() {
        // current user
        self.userInfo = results.filter{$0.fullname == volunteerName }
        
        if(userInfo.count > 0){
            self.taskInfo = taskResults.filter{$0.volunteer == userInfo[0].userId}
//            taskInfo.forEach(<#T##body: (Task) throws -> Void##(Task) throws -> Void#>)
        }
        
        
        //
        //        print("taskresult \(taskResults.count)")
        //        print("taskInfo \(taskInfo)")
        
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
                    VStack(spacing: 160) {
                        
                        let _ = getTaskInfo()
                        if(taskInfo.count > 0) {
                            
                            ForEach(taskInfo) { task in
                                OngoingTaskCard(taskTitle: task.title!, helpseeker: "task.helpseeker", location: task.location!, time: task.time!, date: task.time!)
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
        GeometryReader { geometry in
            VStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .shadow(radius: 5)
                        .frame(width: geometry.size.width * 0.98, height: geometry.size.height * 15, alignment: .center)
                    VStack(alignment: .leading, spacing: 10){
                        HStack(spacing: 160){
                            Text(taskTitle)
                                .font(.headline)
                                .fontWeight(.medium)
                            Text(date!.formatted(date: .numeric, time: .omitted))
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Primary"))
                        }
                        HStack(spacing: 100){
                            Label(helpseeker, systemImage: "person")
//                            Label(location, systemImage: "mappin")
                        }
                        Text("Address: \(location)")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        HStack(spacing:80){
                           
                            Label(time!.formatted(date: .omitted, time: .complete), systemImage: "clock")
                                
                                .font(.system(size: 14))
                                
                                .foregroundColor(.secondary)
                            NavigationLink(destination: TaskDetailView()){
                                Text("View Task")
                                    .font(.subheadline)
                                    .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 3)
                                    .background(Color("Primary"))
                                    .foregroundColor(.white)
                                    .cornerRadius(6)
                            }
                        }
                    }
                }
            }.padding(.vertical, 30)
        }
    }
}


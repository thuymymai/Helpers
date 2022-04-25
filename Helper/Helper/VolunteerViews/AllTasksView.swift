//
//  AllTasksView.swift
//  Helper
//
//  Created by Annie Huynh on 25.4.2022.
//

import SwiftUI

struct AllTasksView: View {
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.title, ascending: true)]) var taskResults: FetchedResults<Task>
    
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
            ScrollView{
                ZStack{
                    Color("Background")
                        .edgesIgnoringSafeArea(.top)
                    
                    VStack(spacing: 30){
                        ForEach(taskResults){task in
                            let helpseeker = getHelpseeker(task: task)
                            TaskCard(title: task.title!, helpseeker: helpseeker.fullname!, location: task.location!, time: task.time!, need: helpseeker.need!)
                                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.25)
                                .background(.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .padding(.horizontal)
                        }
                    }.padding(.vertical)
                }
            }
        }
    }
}

struct AllTasksView_Previews: PreviewProvider {
    static var previews: some View {
        AllTasksView()
    }
}

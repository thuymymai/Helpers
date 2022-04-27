//
//  OthersTasks.swift
//  Helper
//
//  Created by Annie Huynh on 25.4.2022.
//

import SwiftUI

struct OthersTasksView: View {
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.title, ascending: true)]) var taskResults: FetchedResults<Task>
    
    @Binding var others: [Task]
    
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
                        ForEach(others){task in
                            let helpseeker = getHelpseeker(task: task)
                            TaskCard(volunteer: task.volunteer,
                                taskTitle: task.title!, helpseeker: helpseeker.fullname!, location: task.location!,
                                     time: task.time!, need: helpseeker.need!,
                                     desc: task.desc!, chronic: helpseeker.chronic!, allergies: helpseeker.allergies!)                                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.25,alignment: .top)
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
struct OthersTasks_Previews: PreviewProvider {
    static var previews: some View {
        OthersTasksView(others: .constant([]))
    }
}

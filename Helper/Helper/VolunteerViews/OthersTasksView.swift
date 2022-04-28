//
//  OthersTasks.swift
//  Helper
//
//  Created by Annie Huynh on 25.4.2022.
//

import SwiftUI

struct OthersTasksView: View {
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    // tasks information that belongs to others categories
    @Binding var others: [Task]
    @Binding var userInfo: [User]
    @Binding var taskInfo: [Task]
    @Binding var availableTasks: [Task]
    @Binding var volunteerName: String
    
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
                    VStack( spacing: 20){
                        ForEach(others) { task in
                            let helpseeker  = getHelpseeker(task: task)
                            TaskCard(currentTask: task, helpseeker: helpseeker, userInfo: userInfo, volunteerName: volunteerName)
                                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.23,alignment: .top)
                                .background(.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .padding(.horizontal)
                                .padding(.leading,5)
                        }
                    }
                }
            }
        }
    }
}
struct OthersTasks_Previews: PreviewProvider {
    static var previews: some View {
        OthersTasksView(others: .constant([]), userInfo: .constant([]), taskInfo: .constant([]), availableTasks: .constant([]),volunteerName: .constant(""))
    }
}

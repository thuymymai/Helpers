//
//  CatagoryTaskView.swift
//  Helper
//
//  Created by Dang Son on 1.5.2022.
//

import Foundation
import SwiftUI

struct CategoryTaskView: View {
    // user results from core
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    
    // task information based on category
    @Binding var category: [Task]
    @Binding var userInfo: [User]
    @Binding var volunteerName: String
    
    // function to get helpseeker information
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
                        if (category.count > 0) {
                            ForEach(category) { task in
                                let helpseeker  = getHelpseeker(task: task)
                                TaskCard(currentTask: task, helpseeker: helpseeker, userInfo: userInfo, volunteerName: volunteerName)
                                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.23,alignment: .top)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                    .padding(.horizontal)
                                    .padding(.leading,5)
                            }
                        } else {
                            Text("No task is avaiable")
                                .fontWeight(.medium)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .multilineTextAlignment(.center)
                        }
                    }
                }
            }
        }
    }
}

struct CatagoryTasks_Previews: PreviewProvider {
    static var previews: some View {
        CategoryTaskView(category: .constant([]), userInfo: .constant([]),volunteerName: .constant(""))
    }
}

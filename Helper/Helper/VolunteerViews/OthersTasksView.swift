//
//  OthersTasks.swift
//  Helper
//
//  Created by Annie Huynh on 25.4.2022.
//

import SwiftUI

struct OthersTasksView: View {
    
    @Binding var others: [Task]
    @Binding var userInfo: [User]
    @Binding var taskInfo: [Task]
    @Binding var availableTasks: [Task]
    @Binding var volunteerName: String
//    @Binding var currentTask: Task
//    @Binding var helpseeker: User
    var body: some View {
        GeometryReader{geometry in
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                ZStack{
                    VStack(spacing: 20){
                       TaskCard(userInfo: userInfo, taskInfo:taskInfo, availableTasks:availableTasks,categoryTask: others,volunteerName: volunteerName)
                        
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
struct OthersTasks_Previews: PreviewProvider {
    static var previews: some View {
        OthersTasksView(others: .constant([]), userInfo: .constant([]), taskInfo: .constant([]), availableTasks: .constant([]),volunteerName: .constant(""))
    }
}

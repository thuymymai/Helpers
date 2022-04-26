//
//  AvailableTasksView.swift
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
                            TaskCard(title: task.title!, helpseeker: helpseeker.fullname!, location: task.location!, time: task.time!, need: helpseeker.need!)
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
    
    @State var showAlert: Bool = false
    @State var title: String
    @State var helpseeker: String
    @State var location: String
    @State var time: Date?
    @State var need: String
    
    var body: some View {
        VStack{
            HStack{
                Text(title)
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
                VStack(alignment: .leading, spacing: 20) {
                    Text(helpseeker)
                        .font(.subheadline)
                        .fontWeight(.regular)
                    Label(location, systemImage: "mappin")
                        .foregroundColor(.secondary)
                    HStack(spacing:-10) {
                        Image(systemName: "figure.roll")
                        Text("Diability :")
                            .font(.body)
                            .foregroundColor(.primary)
                            .padding(.leading, 20)

                        Text(need.isEmpty ? "wheelchair" : need)
                            .font(.body)
                            .foregroundColor(.primary)
                            .padding(.leading, 20)
                        Spacer()
                    }

                }
                .layoutPriority(100)
                Spacer()
                Button(action: {
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
                        print("Confirmed")
                    }), secondaryButton: .cancel())
                })
            }
            .padding(.horizontal)
        }
    }
}


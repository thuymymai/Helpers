//
//  UploadForm.swift
//  Helper
//
//  Created by Mai Thuỳ My on 12.4.2022.
//

import SwiftUI

struct UploadForm: View {
    @Binding var helpseekerName: String
    @State var userId: Int = 0
    
    // fetching user data from core data
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    
    func getUserInfo() {
        let userInfo = results.filter{$0.fullname == helpseekerName }
        //        print("helpseekerName: \(helpseekerName) count: \(helpseekerName.count)")
        //        print("result count: \(results.count)")
        //        print("user info \(userInfo.count)")
        
        if(userInfo.count > 0){
            self.userId = Int(userInfo[0].userId)
            print("user info id \(userInfo[0].userId)")
            print("userid \(userId)")
        }
    }
    
    var body: some View {
        
        ZStack {
            Color("Background").edgesIgnoringSafeArea(.top)
            
            VStack{
                ZStack(alignment: .top) {
                    Image("BG Mask").edgesIgnoringSafeArea(.all)
                    VStack{
                        Text("Need help?")
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        Text("Fill in the form to find volunteer")
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }.padding(.top, -20)
                }
                Spacer()
            }
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(width: 300, height: 580)
                    .shadow(radius: 5)
                    .padding(.top, 50)
                FormTask(userId: $userId)
            }
            .padding(.bottom,10)
            
        }.onAppear(perform: {getUserInfo()})
            .offset(y:-10)
    }
}

struct UploadForm_Previews: PreviewProvider {
    static var previews: some View {
        UploadForm(helpseekerName: .constant(""))
    }
}

struct FormTask: View {
    @State var description: String = ""
    @State var title: String = ""
    @State private var currentDate = Date()
    @State private var categorySelection = "Others"
    @State var location: String = ""
    @State var isUpload: Bool = false
    @State var showAlert: Bool = false
    @Binding var userId: Int
    
    let categories = ["Groceries", "Delivery", "Personal assistant", "Transportation", "Housework", "Others"]
    
    // set up environment
    @StateObject var taskModel = TaskViewModel()
    @Environment(\.managedObjectContext) var context
    
    // fetching data from core data
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.title, ascending: true)]) var taskResults: FetchedResults<Task>
    
    func uploadTask(title: String, location: String, long: Double, lat: Double, time: Date, category: String, description: String, helpseeker: Int) {
        let task = Task(context: context)
        task.id = (Int16) (taskResults.count + 1)
        task.title = title.lowercased()
        task.location = location.lowercased()
        task.long = (Double) (long)
        task.lat = (Double) (lat)
        task.time = time
        task.category = category.lowercased()
        task.desc = description.lowercased()
        task.helpseeker = Int16(helpseeker)
        task.status = 0
        task.volunteer = 0
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func resetForm() {
        title = ""
        location = ""
        currentDate = Date()
        categorySelection = "Others"
        description = ""
    }
    
    var body: some View {
        ZStack{
            VStack{
                VStack {
                    Text("Title")
                        .fontWeight(.medium)
                        .frame(maxWidth: 300, alignment: .leading)
                        .font(.system(size: 16))
                        .padding(.top,15)
                    TextField("", text: $title)
                        .padding(.bottom, 20)
                        .background(Color("Background"))
                        .cornerRadius(5)
                    Text("Location")
                        .fontWeight(.medium)
                        .frame(maxWidth: 300, alignment: .leading)
                        .font(.system(size: 16))
                        .padding(.top, 10)
                    
                    HStack {
                        TextField("\(location)", text: $location)
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .frame(maxWidth: 200, alignment: .leading)
                        Image(systemName: "map")
                            .foregroundColor(.black)
                    }
                    .frame(width: 230, height: 25)
                    .padding(10)
                    .background(Color("Background"))
                    .cornerRadius(5)
                    
                    Text("Time")
                        .fontWeight(.medium)
                        .frame(maxWidth: 300, alignment: .leading)
                        .font(.system(size: 16))
                        .padding(.top, 10)
                    DatePicker("", selection: $currentDate, displayedComponents: [.date, .hourAndMinute])
                        .labelsHidden()
                        .background(Color("Background"))
                        .frame(alignment: .leading)
                    Text("Category")
                        .fontWeight(.medium)
                        .frame(maxWidth: 300, alignment: .leading)
                        .font(.system(size: 16))
                        .padding(.top, 10)
                    Picker("Select category", selection: $categorySelection) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                                .frame(width: 110, height: 110)
                                .background(.blue)
                        }
                    }.frame(width: 250)
                        .cornerRadius(5)
                        .background(Color("Background"))
                    .pickerStyle(.menu)
                    Text("Description")
                        .fontWeight(.medium)
                        .frame(maxWidth: 300, alignment: .leading)
                        .font(.system(size: 16))
                        .padding(.top, 10)
                    
                    TextEditor(text: $description)
                        .frame(width: 250, height: 110)
                        .colorMultiply(Color("Background"))
                        .cornerRadius(5)
                        .padding(.bottom,-20)
                }
                .frame(width: 250)
                .padding(.top, 30)
                Button(action: { showAlert.toggle() }) {
                    Text("SUBMIT")
                        .fontWeight(.bold)
                        .font(.system(size: 14))
                        .frame(width: 100, height: 35)
                        .background(Color("Primary"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }.alert(isPresented: $showAlert, content: {
                    if self.isUpload {
                        return Alert(title: Text("Submit task failed!"),  dismissButton: .default(Text("Try again!"), action: {}))
                    } else {
                        uploadTask(title: title, location: location, long: 0.0, lat: 0.0, time: currentDate, category: categorySelection, description: description, helpseeker: userId)
                        return Alert(title: Text("Submit task successfully!"),  dismissButton: .default(Text("Got it!"), action: {resetForm()}))
                    }
                })
                .padding(.top, 30)
            }         
        }
        
    }
}


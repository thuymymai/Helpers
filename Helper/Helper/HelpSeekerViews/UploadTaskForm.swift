//
//  UploadTaskForm.swift
//  Helper
//
//  Created by Dang Son on 2.5.2022.
//

import SwiftUI

struct FormTask: View {
    @Binding var userId: Int
    @Binding var locationUser: String
    let locationManager = LocationManager()
    
    @State var description: String = ""
    @State var title: String = ""
    @State private var currentDate = Date()
    @State private var categorySelection = "Others"
    
    @State var showAlert: Bool = false
    @State var isError: Int = 0
    
    let categories = ["Groceries", "Delivery", "Personal assistant", "Transportation", "Housework", "Others"]
    
    // set up environment
    @StateObject var taskModel = TaskViewModel()
    @Environment(\.managedObjectContext) var context
    
    // fetching data from core data
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.title, ascending: true)]) var taskResults: FetchedResults<Task>
    
    func uploadTask(title: String, location: String, long: Double, lat: Double, time: Date, category: String, description: String, helpseeker: Int) {
        DispatchQueue.main.async {
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
    }
    
    func resetForm() {
        title = ""
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
                        TextEditor(text: $locationUser)
                            .colorMultiply(Color("Background"))
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .frame(width: 200, height: 50 ,alignment: .leading)
                        Image(systemName: "map")
                            .foregroundColor(.black)
                    }
                    .frame(width: 230, height: 50)
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
                    }
                    .frame(width: 250)
                    .background(Color("Background"))
                    .cornerRadius(5)
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
                Button(action: {
                    locationManager.getLocation(forPlaceCalled: locationUser) { location in
                        guard let location = location else {
                            isError = 1
                            return
                        }
                        uploadTask(title: title, location: locationUser, long: location.coordinate.longitude, lat: location.coordinate.latitude, time: currentDate, category: categorySelection, description: description, helpseeker: userId)
                    }
                    showAlert.toggle()
                    Thread.sleep(forTimeInterval: 1)
                }) {
                    Text("SUBMIT")
                        .fontWeight(.bold)
                        .font(.system(size: 14))
                        .frame(width: 100, height: 35)
                        .background(Color("Primary"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .alert(isPresented: $showAlert, content: {
                    if(isError == 1) {
                        return Alert(title: Text("Cannot find your location!"),  dismissButton: .default(Text("Try again"), action: { self.isError = 0}))
                    } else {
                        let _ = registerForPushNotifications()
                        return  Alert(title: Text("Submit task successfully!"),  dismissButton: .default(Text("OK"), action: {
                            resetForm()
                        }))
                    }
                })
                .padding(.top, 30)
            }
        }
    }
}

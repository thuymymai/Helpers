//
//  UploadForm.swift
//  Helper
//
//  Created by Mai Thuỳ My on 12.4.2022.
//

import SwiftUI

struct UploadForm: View {
    var body: some View {
        NavigationView{
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
                        }.padding(.top, 30)
                    }
                    Spacer()
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .frame(width: 300, height: 580)
                        .shadow(radius: 5)
                        .padding(.top, 50)
                    FormTask()
                }.padding(.top, 30)
                
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct UploadForm_Previews: PreviewProvider {
    static var previews: some View {
        UploadForm()
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
    
    let categories = ["Groceries", "Delivery", "Personal assistant", "Transportation", "Housework", "Others"]
    
    // set up environment
    @StateObject var taskModel = TaskViewModel()
    @Environment(\.managedObjectContext) var context
    
    // fetching data from core data
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.title, ascending: true)]) var taskResults: FetchedResults<Task>
    
    func uploadTask(title: String, location: String, long: Double, lat: Double, time: Date, category: String, description: String) {
        let task = Task(context: context)
        task.title = title.lowercased()
        task.location = location.lowercased()
        task.long = (Double) (long)
        task.lat = (Double) (lat)
        task.time = time
        task.category = category.lowercased()
        task.desc = description.lowercased()
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
                    TextField("", text: $title)
                        .padding(.bottom, 20)
                        .background(Color("Background"))
                        .cornerRadius(5)
                    Text("Location")
                        .fontWeight(.medium)
                        .frame(maxWidth: 300, alignment: .leading)
                        .font(.system(size: 16))
                        .padding(.top, 10)
                    NavigationLink(
                        destination: HelpSeekerMapView(),
                        label: {
                            HStack {
                                Text("Choose on map")
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
                        })
                    Text("Time")
                        .fontWeight(.medium)
                        .frame(maxWidth: 300, alignment: .leading)
                        .font(.system(size: 16))
                        .padding(.top, 10)
                    DatePicker("", selection: $currentDate, displayedComponents: [.date, .hourAndMinute])
                        .labelsHidden()
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
                    .pickerStyle(.menu)
                    Text("Description")
                        .fontWeight(.medium)
                        .frame(maxWidth: 300, alignment: .leading)
                        .font(.system(size: 16))
                        .padding(.top, 10)
                    TextField("", text: $description)
                        .padding(.bottom, 40)
                        .background(Color("Background"))
                        .cornerRadius(5)
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
                        uploadTask(title: title, location: location, long: 0.0, lat: 0.0, time: currentDate, category: categorySelection, description: description)
                        return Alert(title: Text("Submit task successfully!"),  dismissButton: .default(Text("Got it!"), action: {resetForm()}))
                    }
                })
                .padding(.top, 30)
            }
            
        }
        
    }
}


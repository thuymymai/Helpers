//
//  AvailabilityForm.swift
//  Helper
//
//  Created by Dang Son on 1.5.2022.
//

import SwiftUI
import CoreData

struct AvailabilityForm: View {
    
    @Binding var fullname: String
    @Binding var email: String
    @Binding var phone: String
    @Binding var password: String
    
    @State private var userInfo: [User] = []
    @State private var taskInfo: [Task] = []
    @State private var availableTasks: [Task] = []
    
    @State var toDashboard: Bool = false
    @State var showAlert: Bool = false
    @State var isManyTimesChecked: Bool = false
    @State var isDailyChecked: Bool = false
    @State var isWeeklyChecked: Bool = false
    @State var isMonthlyChecked: Bool = false
    @State var signupFailed = false
    @State var availability: String = ""
    
    // get singleton from ContentView
    private let shared = ContentView.shared
    
    // set up environment
    @StateObject var userModel = UserViewModel()
    @Environment(\.managedObjectContext) var context
    
    // fetching data from core data
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    
    func updateUser(fullname: String, password: String, email: String, phone: String, type: String, availability: String, note: String, location: String, long: Double, lat: Double, need: String, chronic: String, allergies: String) {
        let user = User(context: context)
        user.userId = (Int16) (results.count + 1)
        user.fullname = fullname.lowercased()
        user.password = password
        user.email = email.lowercased()
        user.phone = phone
        user.type = type.lowercased()
        user.availability = availability.lowercased()
        user.note = note.lowercased()
        user.location = location.lowercased()
        user.long = (Double) (long)
        user.lat = (Double) (lat)
        user.need = need.lowercased()
        user.chronic = chronic.lowercased()
        user.allergies = allergies.lowercased()
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 40) {
            VStack(alignment: .leading) {
                Button(action: {
                    isManyTimesChecked.toggle()
                }) {
                    HStack(spacing: 46){
                        Text("Several times per day")
                            .foregroundColor(.black)
                            .font(.system(size: 18))
                        Image(systemName: isManyTimesChecked ? "checkmark.circle.fill" : "checkmark.circle"  )
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .trailing)
                            .foregroundColor(Color("Primary"))
                    }
                }
                Divider().frame(width: 250, height:1).background(Color("Primary"))
            }
            VStack(alignment: .leading) {
                Button(action: {
                    isDailyChecked.toggle()
                }) {
                    HStack(spacing: 180){
                        Text("Daily")
                            .foregroundColor(.black)
                            .font(.system(size: 18))
                        Image(systemName: isDailyChecked ? "checkmark.circle.fill" : "checkmark.circle"  )
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .trailing)
                            .foregroundColor(Color("Primary"))
                    }
                }
                Divider().frame(width: 250, height:1).background(Color("Primary"))
            }
            VStack(alignment: .leading) {
                Button(action: {
                    isWeeklyChecked.toggle()
                }) {
                    HStack(spacing: 162){
                        Text("Weekly")
                            .foregroundColor(.black)
                            .font(.system(size: 18))
                        Image(systemName: isWeeklyChecked ? "checkmark.circle.fill" : "checkmark.circle"  )
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .trailing)
                            .foregroundColor(Color("Primary"))
                    }
                }
                Divider().frame(width: 250, height:1).background(Color("Primary"))
            }
            
            VStack(alignment: .leading) {
                Button(action: {
                    isMonthlyChecked.toggle()
                }) {
                    HStack(spacing: 155){
                        Text("Monthly")
                            .foregroundColor(.black)
                            .font(.system(size: 18))
                        Image(systemName: isMonthlyChecked ? "checkmark.circle.fill" : "checkmark.circle"  )
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .trailing)
                            .foregroundColor(Color("Primary"))
                    }
                }
                Divider().frame(width: 250, height:1).background(Color("Primary"))
            }
            NavigationLink(destination: VolunteersNavBar( volunteerName: $fullname)
                .navigationBarHidden(true), isActive: self.$toDashboard) { EmptyView() }
            Button(action: {
                showAlert.toggle()
            }) {
                Text("REGISTER")
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                    .frame(width: 100, height: 35)
                    .background(Color("Primary"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }.alert(isPresented: $showAlert, content: {
                if self.signupFailed {
                    return Alert(title: Text("Register failed!"),  dismissButton: .default(Text("Try again!"), action: {self.toDashboard = false}))
                } else {
                    if(isManyTimesChecked == true) {
                        availability = "1"
                    } else if(isDailyChecked == true) {
                        availability = "2"
                    } else if(isWeeklyChecked == true) {
                        availability = "3"
                    } else {
                        availability = "4"
                    }
                    // get current location from phone
                    let sharedLocation = shared.locationManager
                    
                    // update location of new user
                    if (sharedLocation.address != "") {
                        updateUser(fullname: fullname, password: password, email: email, phone: phone, type: "v", availability: availability, note: "", location: sharedLocation.address, long: sharedLocation.long, lat: sharedLocation.lat, need: "", chronic: "", allergies: "")
                    } else {
                        updateUser(fullname: fullname, password: password, email: email, phone: phone, type: "v", availability: availability, note: "", location: "", long: 0.0, lat: 0.0, need: "", chronic: "", allergies: "")
                    }
                    return Alert(title: Text("Register successfully!"),  dismissButton: .default(Text("Got it!"), action: {self.toDashboard = true}))
                }
            })
            .padding(.top, 20)
            .padding(.leading, 70)
        }
    }
}

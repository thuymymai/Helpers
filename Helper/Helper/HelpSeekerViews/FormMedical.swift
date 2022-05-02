//
//  FormMedical.swift
//  Helper
//
//  Created by Dang Son on 2.5.2022.
//

import SwiftUI
import CoreData

struct FormMedical: View {
    @Binding var fullname: String
    @Binding var email: String
    @Binding var phone: String
    @Binding var password: String
    
    
    @State var info: String = ""
    @State var isLinkActive = false
    @State var showAlert: Bool = false
    @State var signupFailed = false
    
    // get singleton from ContentView
    private let shared = ContentView.shared
    
    // set up environment
    @StateObject var userModel = UserViewModel()
    @Environment(\.managedObjectContext) var context
    
    // fetching data from core data
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    
    // set up medical info
    @State private var disabilitySelection = "None"
    let specialNeeds = ["None", "Autism", "Down syndrome", "Blindness", "Deafness", "Immobilized", "ADHD"]
    
    @State private var diseaseSelection = "None"
    let diseases = ["None", "Heart disease", "Stroke", "Cancer", "Depression", "Diabetes", "Arthritis", "Asthma", "Oral disease"]
    
    @State private var allergySelection = "None"
    let allergies = ["None", "Grass", "Pollen", "Dust mites", "Animal dander", "Nuts", "Gluten", "Lactose", "Mould"]
    
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
        ZStack{
            VStack{
                VStack(spacing:15) {
                    Text("Special needs")
                        .fontWeight(.medium)
                        .frame(maxWidth: 300, alignment: .leading)
                        .font(.system(size: 16))
                    Picker("Select need", selection: $disabilitySelection) {
                        ForEach(specialNeeds, id: \.self) {
                            Text($0)
                                .frame(width: 110, height: 110)
                                .background(.blue)
                        }
                    }.frame(width: 250)
                        .cornerRadius(5)
                        .background(Color("Background"))
                        .pickerStyle(.menu)
                    Text("Chronic diseases")
                        .fontWeight(.medium)
                        .frame(maxWidth: 300, alignment: .leading)
                        .font(.system(size: 16))
                        .padding(.top, 10)
                    Picker("Select disease", selection: $diseaseSelection) {
                        ForEach(diseases, id: \.self) {
                            Text($0)
                                .frame(width: 110, height: 110)
                                .background(.blue)
                        }
                    }.frame(width: 250)
                        .cornerRadius(5)
                        .background(Color("Background"))
                        .pickerStyle(.menu)
                    Text("Allergies")
                        .fontWeight(.medium)
                        .frame(maxWidth: 300, alignment: .leading)
                        .font(.system(size: 16))
                        .padding(.top, 10)
                    Picker("Select disease", selection: $allergySelection) {
                        ForEach(allergies, id: \.self) {
                            Text($0)
                                .frame(width: 110, height: 110)
                                .background(.blue)
                        }
                    }
                    .frame(width: 250)
                    .cornerRadius(5)
                    .background(Color("Background"))
                    .pickerStyle(.menu)
                    Text("Others")
                        .fontWeight(.medium)
                        .frame(maxWidth: 300, alignment: .leading)
                        .font(.system(size: 16))
                        .padding(.top, 10)
                    TextEditor( text: $info)
                        .frame(width: 250, height: 110)
                        .colorMultiply(Color("Background"))
                        .cornerRadius(5)
                        .padding(.bottom,-20)
                }
                .frame(width: 250)
                NavigationLink(destination: HelpSeekerNavBar(helpseekerName: $fullname).navigationBarHidden(true), isActive: self.$isLinkActive) { }
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
                        .padding(.top, 10)
                }.alert(isPresented: $showAlert, content: {
                    if self.signupFailed {
                        return Alert(title: Text("Register failed!"),  dismissButton: .default(Text("Try again!"), action: {self.isLinkActive = false}))
                    } else {
                        // get current location from phone
                        let sharedLocation = shared.locationManager
                        
                        // update location of new user
                        if (sharedLocation.address != "") {
                            updateUser(fullname: fullname, password: password, email: email, phone: phone, type: "h", availability: "", note: "", location: sharedLocation.address, long: sharedLocation.long, lat: sharedLocation.lat, need: disabilitySelection, chronic: diseaseSelection, allergies: allergySelection)
                        } else {
                            updateUser(fullname: fullname, password: password, email: email, phone: phone, type: "h", availability: "", note: "", location: "", long: 0.0, lat: 0.0, need: disabilitySelection, chronic: diseaseSelection, allergies: allergySelection)
                        }
                        return Alert(title: Text("Register successfully!"),  dismissButton: .default(Text("Got it!"), action: {self.isLinkActive = true}))
                    }
                })
                .padding(.top, 40)
            }
            
        }
        
    }
}

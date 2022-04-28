//
//  RegisterAvailability.swift
//  Helper
//
//  Created by Annie Huynh on 18.4.2022.
//

import SwiftUI

struct RegisterAvailability: View {
    
    @Binding var fullname: String
    @Binding var email: String
    @Binding var phone: String
    @Binding var password: String
 
    var body: some View {
        GeometryReader { geometry in
            NavigationView{
                ZStack(alignment: .top){
                    Color("Background").edgesIgnoringSafeArea(.all)
                    VStack{
                        ZStack(alignment: .top){
                            Image("BG Mask").edgesIgnoringSafeArea(.all)
                            Text("Select your availability")
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                                .frame(maxWidth: geometry.size.width * 0.7, alignment: .center)
                                .foregroundColor(.white)
                        }.offset(y:-60)
                        Spacer()
                        Text("By signup and login, I confirm that I have read and agree to  Helpers Terms & Privacy Policy")
                            .bold()
                            .frame(maxWidth: 280)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 14))
                            .padding(.bottom, 10)
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.7)
                            .shadow(radius: 5)
                            .padding(.top, 60)
                        AvailabilityForm(fullname: $fullname, email: $email, phone: $phone, password: $password)
                            .padding(.top, 80)
                    } .offset(y:-50)
                }
            }
        }
    }
}

struct RegisterAvailability_Previews: PreviewProvider {
    static var previews: some View {
        RegisterAvailability(fullname: .constant(""), email: .constant(""), phone: .constant(""), password: .constant(""))
    }
}

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
    
    // set up environment
    @StateObject var userModel = UserViewModel()
    @Environment(\.managedObjectContext) var context
    
    // fetching data from core data
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    
    func toggle(){
        isManyTimesChecked = !isManyTimesChecked
    }
    func toggleDaily(){
        isDailyChecked = !isDailyChecked
    }
    func toggleWeekly(){
        isWeeklyChecked = !isWeeklyChecked
    }
    func toggleMonthly(){
        isMonthlyChecked = !isMonthlyChecked
    }
    
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
                Button(action: toggle){
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
                Button(action: toggleDaily){
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
                Button(action: toggleWeekly){
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
                Button(action: toggleMonthly){
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
                    updateUser(fullname: fullname, password: password, email: email, phone: phone, type: "v", availability: availability, note: "", location: "", long: 0.0, lat: 0.0, need: "", chronic: "", allergies: "")
                    return Alert(title: Text("Register successfully!"),  dismissButton: .default(Text("Got it!"), action: {self.toDashboard = true}))
                }
            })
            .padding(.top, 20)
            .padding(.leading, 70)
        }
    }
}

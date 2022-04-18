//
//  RegisterAvailability.swift
//  Helper
//
//  Created by Annie Huynh on 18.4.2022.
//

import SwiftUI

struct RegisterAvailability: View {
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
                        }
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
                        AvailabilityForm().padding(.top, 80)
                    }
                    
                    
                }
            }
        }
    }
}

struct RegisterAvailability_Previews: PreviewProvider {
    static var previews: some View {
        RegisterAvailability()
    }
}

struct AvailabilityForm: View {
    @State var toDashboard: Bool = false
    @State var showAlert: Bool = false
    @State var isManyTimesChecked: Bool = false
    @State var isDailyChecked: Bool = false
    @State var isWeeklyChecked: Bool = false
    @State var isMonthlyChecked: Bool = false
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
            NavigationLink(destination: VolunteersNavBar().navigationBarBackButtonHidden(true), isActive: self.$toDashboard) { EmptyView() }
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
                Alert(title: Text("Register successfully"), message: Text("Register successfully. Go to Dashboard"), dismissButton: .default(Text("Got it!"), action: {self.toDashboard = true}))
            })
            .padding(.top, 20)
            .padding(.leading, 70)
        }
    }
}

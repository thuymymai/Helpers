//
//  FrontScreen.swift
//  Helper
//
//  Created by Mai Thuỳ My on 10.4.2022.
//

import SwiftUI
import CoreLocation

struct FrontScreen: View {
    @Binding var helpseekerName: String
    @State var phoneNumber: (String?, Double?) = ("", 0.0)
    
    // fetching user data from core data
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    
    func getPhoneNumber() {
        let userInfo = results.filter{$0.fullname?.lowercased() == helpseekerName }
        if(userInfo.count > 0){
            let users = results.filter{$0.type != userInfo[0].type}
            let distanceAndPhone = users.map{ ($0.phone, CLLocation(latitude: userInfo[0].lat, longitude: userInfo[0].long).distance(from: CLLocation(latitude: $0.lat, longitude: $0.long))/1000) }
            let distance = distanceAndPhone.map {$0.1}
            self.phoneNumber = distanceAndPhone.first(where: {$0.1 == distance.min()})!
        }
    }
    
    var body: some View {
//        NavigationView {
            ZStack(alignment: .top){
                Color("White")
                    .edgesIgnoringSafeArea(.top)
                VStack{
                    HStack(alignment: .top){
                        Spacer()
                        VStack{
                            Text("Karaportti 2, Espoo")
                                .font(.system(size: 16))
                                .padding(.bottom, 2)
                            NavigationLink(
                                destination: HelpSeekerMapView(),
                                label: {
                                    HStack {
                                        Text("See your location")
                                            .bold()
                                            .font(.system(size: 16))
                                            .foregroundColor(Color("Primary"))
                                        Image(systemName: "location.fill")
                                            .foregroundColor(.red)
                                    }
                                })
                        }.padding(.top, 30)
                    }
                    .padding(.bottom, 50)
                    .padding(.trailing, 10)
                    
                    Text("Emergency help needed?")
                        .bold()
                        .font(.system(size: 24))
                        .padding(.bottom, 5)
                    Text("Press button to call the nearest volunteer")
                        .padding(.bottom, 20)
                        .font(.system(size: 18))
                    EmergencyButton(phoneNumber: phoneNumber.0!)
                    Text("First-aid manual")
                        .bold()
                        .padding(.top, 70)
                        .font(.system(size: 20))
                    FirstAidManual().offset(y:-10)
                }
            }
            .onAppear(perform: {getPhoneNumber()})
            .offset(y:-40)
//            .navigationBarTitle("")
//            .navigationBarHidden(true)
//            .navigationBarBackButtonHidden(true)
//        }
    }
}

struct FrontScreen_Previews: PreviewProvider {
    static var previews: some View {
        FrontScreen(helpseekerName: .constant(""))
    }
}

struct EmergencyButton: View {
    var phoneNumber: String
    var body: some View {
        ZStack{
            Circle()
                .fill(Color("Background"))
                .frame(width: 300, height: 170)
                .shadow(color: .gray, radius: 5, x: 0, y: 5)
//            Image("emergency-button")
            Button(action: {
                let _ = print("phone number is : \(phoneNumber)")
                if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
                    let application:UIApplication = UIApplication.shared
                    if (application.canOpenURL(phoneCallURL)) {
                        application.open(phoneCallURL, options: [:], completionHandler: nil)
                    }
                }
            }) {
                Image("emergency-button")
            }
        }
        
//        .onTapGesture {
//            let _ = print("phone number is : \(phoneNumber)")
//            if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
//                let application:UIApplication = UIApplication.shared
//                if (application.canOpenURL(phoneCallURL)) {
//                    application.open(phoneCallURL, options: [:], completionHandler: nil)
//                }
//            }
//        }
        
    }
}

struct FirstAidManual: View {
    let array = [Firstaid.Choking, Firstaid.BrokenBone, Firstaid.Allergy, Firstaid.BeeStings, Firstaid.Bleeding, Firstaid.Burns, Firstaid.Drowning, Firstaid.ElectricShock, Firstaid.HeartAttack, Firstaid.Hypothermia, Firstaid.NoseBleeds, Firstaid.Poisoning, Firstaid.Sprains, Firstaid.Stroke]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                ForEach(array, id: \.self) { firstaid in
                    NavigationLink {
                        FirstAid(stt: firstaid) }
                label: {
                    ZStack{
                        Rectangle()
                            .fill(Color("Background"))
                            .frame(width: 150, height: 120)
                            .cornerRadius(10)
                            .shadow(color: .gray, radius: 2, x: 0, y: 2)
                        VStack{
                            Text("\(String(describing: firstaid))")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .frame(maxWidth: 120, alignment: .leading)
                                .font(.system(size: 16))
                            HStack{
                                Image(systemName: "arrow.right.circle.fill")
                                    .frame(maxWidth: 60, alignment: .leading)
                                    .font(.system(size: 22))
                                    .foregroundColor(Color("Primary"))
                                    .padding(.top)
                                Image("firstaid")
                            }
                        }
                    }.padding()
                }
                }
            }.frame(height: 150)
        }.padding()
    }
}

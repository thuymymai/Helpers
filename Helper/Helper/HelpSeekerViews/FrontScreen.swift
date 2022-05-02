//
//  FrontScreen.swift
//  Helper
//
//  Created by Mai Thuỳ My on 10.4.2022.
//

import SwiftUI
import CoreData
import CoreLocation

struct FrontScreen: View {
    @Binding var helpseekerName: String
    @State var phoneNumber: (String?, Double?) = ("", 0.0)
    @State var location: String = ""
    
    // fetching user data from core data
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    
    func getUserData() {
        let userInfo = results.filter{$0.fullname?.lowercased() == helpseekerName.lowercased() }
        if(userInfo.count > 0){
            //get currrent user location
            let address = userInfo[0].location!.split(separator: ",")
            self.location = String(address[0])
            
            //get volunteer is the closest with current user
            let users = results.filter{$0.type != userInfo[0].type}
            let distanceAndPhone = users.map{ ($0.phone, CLLocation(latitude: userInfo[0].lat, longitude: userInfo[0].long).distance(from: CLLocation(latitude: $0.lat, longitude: $0.long))/1000) }
            let distance = distanceAndPhone.map {(Int($0.1))}
            self.phoneNumber = distanceAndPhone.first(where: {Int($0.1) == distance.min()})!
        }
    }
    
    var body: some View {
        ZStack {
            Color("White")
                .edgesIgnoringSafeArea(.top)
            VStack{
                HStack(alignment: .top){
                    Spacer()
                    VStack{
                        Text(location)
                            .font(.system(size: 16))
                            .padding(.bottom, 2)
                        NavigationLink(
                            destination: Location(volunteerName: $helpseekerName),
                            label: {
                                HStack {
                                    Text("See the map")
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
                    .frame(maxWidth: 350)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 20)
                    .font(.system(size: 18))
                    .multilineTextAlignment(.center)
                EmergencyButton(phoneNumber: phoneNumber.0!)
                Text("First Aid Manual")
                    .bold()
                    .padding(.top, 100)
                    .font(.system(size: 20))
                FirstAidManual().padding(.top,-20)
            }
            .offset(y:-10)
        }
        .onAppear(perform: {getUserData()})
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
            Button(action: {
                if (phoneNumber != "") {
                    if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
                        let application:UIApplication = UIApplication.shared
                        if (application.canOpenURL(phoneCallURL)) {
                            application.open(phoneCallURL, options: [:], completionHandler: nil)
                        }
                    }
                }
            }) {
                Image("emergency-button")
            }
        }
    }
}


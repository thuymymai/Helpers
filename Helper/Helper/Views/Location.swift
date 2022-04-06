//
//  Location.swift
//  Helper
//
//  Created by Annie Huynh on 6.4.2022.
//


import SwiftUI

struct Location: View {
    var body: some View {
        NavigationView {
            VStack {
                    Image("location")
                        .resizable()
                        .scaledToFit()
                    Text("Hi, nice to meet you !")
                        .font(.title)
                        .bold()
                    Text("Choose your location to find \nhelp seekers around you. ")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("Primary"))
                        .padding(.all, 20)
                    
                    NavigationLink(
                        destination: VolunteerDashboard().navigationBarBackButtonHidden(true).navigationBarHidden(true),
                        label: {
                            HStack {
                                Image(systemName: "location.fill")
                                    .foregroundColor(Color("Secondary"))
                                
                                Text("Use current location")
                                    .bold()
                                    .foregroundColor(Color("Secondary"))
                                
                            }
                            .frame(width: 300, height: 60, alignment: .center)
                            .border(Color("Secondary"), width: 3)
                            .cornerRadius(5)
                        })
                    
                    Text("Select Manually")
                        .bold()
                        .underline()
                        .foregroundColor(.gray)
                        .padding(.top, 80)
                    Spacer()
                    
            }
        }

    }
    
}

struct Location_Previews: PreviewProvider {
    static var previews: some View {
        Location()
    }
}

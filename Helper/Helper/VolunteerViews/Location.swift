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
            ZStack{
                Color("Background")
                    .edgesIgnoringSafeArea(.top)
                VStack {
                    Image("location")
                        .resizable()
                        .scaledToFit()
                    Text("Locate on map")
                        .font(.title)
                        .bold()
                    Text("Choose your location to find \nhelp seekers around you. ")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("Primary"))
                        .padding(.all, 20)
                    
                    NavigationLink(
                        destination: MapView().navigationBarBackButtonHidden(true),
                        label: {
                            HStack {
                                Image(systemName: "location.fill")
                                    .foregroundColor(.white)

                                Text("Go To Map")
                                    .bold()
                                    .foregroundColor(.white)

                            }
                            .frame(width: 280, height: 60, alignment: .center)
                            .background(Color("Primary"))
                            .cornerRadius(5)
                        }).padding(.top, 10)
                    
                 
                    
                }
            }
        }
        
    }
    
}

struct Location_Previews: PreviewProvider {
    static var previews: some View {
        Location()
    }
}

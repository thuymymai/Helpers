//
//  Location.swift
//  Helper
//
//  Created by Annie Huynh on 6.4.2022.
//


import SwiftUI
import MapKit

struct Location: View {
    
//    @IBOutlet weak var mapView: MKMapView!
//
//    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        createAnnotations(users: results)
//    }
//
//    func createAnnotations(users: FetchedResults<User>) {
//        for user in users {
//            let annotations = MKPointAnnotation()
//            annotations.title = user.fullname
//            annotations.coordinate = CLLocationCoordinate2D(latitude: user.lat, longitude: user.long)
//            mapView.addAnnotation(annotations)
//        }
//    }
    
    @Binding var volunteerName: String
    
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
                        destination: MapView(volunteerName: $volunteerName).navigationBarBackButtonHidden(true),
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
        Location(volunteerName: .constant(""))
    }
}

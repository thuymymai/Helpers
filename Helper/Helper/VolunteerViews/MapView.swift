//
//  MpView.swift
//  Helper
//
//  Created by Annie Huynh on 6.4.2022.
//

import SwiftUI
import CoreLocation
import CoreLocationUI
import MapKit


struct MapView: View {

    @Binding var volunteerName: String
    
    // fetching user data from core data
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    
    @State var annotation: [MyAnnotationItem] = []
//    = [MyAnnotationItem(id: "Jennie", coordinate: CLLocationCoordinate2D(latitude: 60.157683, longitude: 24.542975), distance: 0.0, phoneNumber: "1234"), MyAnnotationItem(id: "Harry", coordinate: CLLocationCoordinate2D(latitude: 60.257, longitude: 24.642), distance: 0.0, phoneNumber: "1234")]
    
    func getAnnotation() {
//        if let indexOfUser = results.firstIndex(where: {$0.fullname?.lowercased() == volunteerName.lowercased()}) {
//            for user in results {
//                if (user.type != results[indexOfUser].type) {
//                    annotation.append(MyAnnotationItem(id: user.fullname ?? "", coordinate: CLLocationCoordinate2D(latitude: user.lat, longitude: user.long), distance: CLLocation(latitude: results[indexOfUser].lat, longitude: results[indexOfUser].long).distance(from: CLLocation(latitude: user.lat, longitude: user.long))/1000, phoneNumber: user.phone!))
//                }
//            }
//        }
        let currentUser = results.filter{$0.fullname?.lowercased() == volunteerName.lowercased() }
        for user in results {
            if(user.type != currentUser[0].type) {
                annotation.append(MyAnnotationItem(id: user.fullname ?? "", coordinate: CLLocationCoordinate2D(latitude: user.lat, longitude: user.long), distance: CLLocation(latitude: currentUser[0].lat, longitude: currentUser[0].long).distance(from: CLLocation(latitude: user.lat, longitude: user.long))/1000, phoneNumber: user.phone ?? "0123241"))
            }
        }
    }
    
    @StateObject private var viewModel = MapViewModel()
    var body: some View {
        ZStack(alignment: .bottom){
            let _ = print("number of annotation \(annotation.count)")
            let _ = print("annotation \(annotation)")
            if (annotation.count > 0) {
                Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: annotation) { item in
                    MapAnnotation(coordinate: item.coordinate) {
                        PlaceAnnotationView(item: item)
                    }
                }
                .edgesIgnoringSafeArea(.top)
                .tint(.pink)
            }
            
            else {
                Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                    .edgesIgnoringSafeArea(.top)
                    .tint(.pink)
            }
            Button {
                viewModel.requestAllowOnceLocationPermission()
            } label: {
                Label("Your location", systemImage: "location.fill")
                    .font(.system(size: 18))
                    .padding()

            }
            .background(Color("Primary"))
            .cornerRadius(10)
            .foregroundColor(.white)
            .padding(.bottom, 30)
            
        }
        .onAppear(perform: {getAnnotation()})
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(volunteerName: .constant(""))
    }
}

struct MyAnnotationItem: Identifiable {
    let id: String
    var coordinate: CLLocationCoordinate2D
    var distance: Double
    var phoneNumber: String
}

struct PlaceAnnotationView: View {
    @State private var showInfo = true
    
    var item: MyAnnotationItem
    
    var body: some View {
        VStack() {
            Image(systemName: "mappin.circle.fill")
                    .font(.title)
                    .foregroundColor(.red)
            Text(item.id)
                .opacity(showInfo ? 0 : 1)
            if (Locale.preferredLanguages[0] == "fi") {
                Text("Etäisyys: \(String(format: "%.1f", item.distance)) km")
                .opacity(showInfo ? 0 : 1)
                Text("Puhelinnumero: \(item.phoneNumber)")
                    .opacity(showInfo ? 0 : 1)
            } else {
                Text("Distance: \(String(format: "%.1f", item.distance)) km")
                    .opacity(showInfo ? 0 : 1)
                Text("Phone: \(item.phoneNumber)")
                    .opacity(showInfo ? 0 : 1)
            }
            
            Button(action: {
                if let phoneCallURL = URL(string: "tel://\(item.phoneNumber)") {
                    let application:UIApplication = UIApplication.shared
                    if (application.canOpenURL(phoneCallURL)) {
                        application.open(phoneCallURL, options: [:], completionHandler: nil)
                    }
                }
            }) {
                if (Locale.preferredLanguages[0] == "fi") {
                    Text("SOITTAA")
                        .fontWeight(.bold)
                        .font(.system(size: 14))
                        .frame(width: 100, height: 35)
                        .background(Color("Primary"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .opacity(showInfo ? 0 : 1)
                } else {
                    Text("CALL")
                        .fontWeight(.bold)
                        .font(.system(size: 14))
                        .frame(width: 100, height: 35)
                        .background(Color("Primary"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .opacity(showInfo ? 0 : 1)
                }
            }
        }
        .onTapGesture {
            withAnimation(.easeInOut) {
                showInfo.toggle()
            }
        }
    }
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{

    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40, longitude: 120), span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))

    let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
    }
    func requestAllowOnceLocationPermission(){
        locationManager.requestLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else {
            return
        }
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(center: latestLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

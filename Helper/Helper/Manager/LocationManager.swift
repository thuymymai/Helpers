//
//  LocationManager.swift
//  Helper
//
//  Created by Dang Son on 25.4.2022.
//

import Foundation
import CoreLocationUI
import MapKit

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    var long: Double = 0.0
    var lat: Double = 0.0
    var address: String = ""
    
    private let locationManager = CLLocationManager()
    
    // API
    public var exposedLocation: CLLocation? {
        return self.locationManager.location
    }
        
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestLocation()
//        self.locationManager.startUpdatingLocation()
    }
}

// Core Location Delegate
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        switch status {
            case .notDetermined         : print("location permission notDetermined")        // location permission not asked for yet
            case .authorizedWhenInUse   : print("location permission authorizedWhenInUse")  // location authorized
            case .authorizedAlways      : print("location permission authorizedAlways")     // location authorized
            case .restricted            : print("location permission restricted")           // TODO: handle
            case .denied                : print("location permission denied")               // TODO: handle
            @unknown default            : print("location permission unknown")
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get users location.")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location update:: \(locations[0])")
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(locations[0]) { placemarks, error in
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
//                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
//                completion(nil)
                return
            }

            if placemark != nil {
                self.address = placemark.name! + ", " + placemark.postalCode! + " " + placemark.locality! + ", " + placemark.country!
                self.lat = (placemark.location?.coordinate.latitude)!
                self.long = (placemark.location?.coordinate.longitude)!
            }
//            var output = "Our location is:"
//            if let country = placemark.country {
//                output = output + "\n\(country)"
//            }
//            if let state = placemark.administrativeArea {
//                output = output + "\n\(state)"
//            }
//            if let town = placemark.locality {
//                output = output + "\n\(town)"
//            }
//            if let street = placemark.name {
//                output = output + "\n\(street)"
//            }
//            if let postCode = placemark.postalCode {
//                output = output + "\n\(postCode)"
//            }
//            let _ = print("address is \(output)")
        
        }
    }
}

//// Get Placemark
//extension LocationManager {
//
////    func getPlace(for location: CLLocation, completion: @escaping (CLPlacemark?) -> Void) {
//    func getPlace(for location: CLLocation) {
//        
//        let geocoder = CLGeocoder()
//        geocoder.reverseGeocodeLocation(location) { placemarks, error in
//            guard error == nil else {
//                print("*** Error in \(#function): \(error!.localizedDescription)")
////                completion(nil)
//                return
//            }
//
//            guard let placemark = placemarks?[0] else {
//                print("*** Error in \(#function): placemark is nil")
////                completion(nil)
//                return
//            }
//
////            completion(placemark)
//        }
//    }
//}

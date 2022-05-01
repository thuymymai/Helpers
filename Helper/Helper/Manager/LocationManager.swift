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
    
    // create singleton of location manager
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
    }
}

// Core Location Delegate
extension LocationManager: CLLocationManagerDelegate {
    
    // check permission for using location
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        switch status {
            case .notDetermined         : print("location permission notDetermined")        // location permission not asked for yet
            case .authorizedWhenInUse   : print("location permission authorizedWhenInUse")  // location authorized
            case .authorizedAlways      : print("location permission authorizedAlways")     // location authorized
            case .restricted            : print("location permission restricted")
            case .denied                : print("location permission denied")
            @unknown default            : print("location permission unknown")
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get users location.")
    }
    
    // get current location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location update:: \(locations[0])")
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(locations[0]) { placemarks, error in
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                return
            }

            if placemark != nil {
                self.address = placemark.name! + ", " + placemark.postalCode! + " " + placemark.locality! + ", " + placemark.country!
                self.lat = (placemark.location?.coordinate.latitude)!
                self.long = (placemark.location?.coordinate.longitude)!
            }
        }
    }
    
    // get location from address
    func getLocation(forPlaceCalled name: String, completion: @escaping(CLLocation?) -> Void) {
            
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(name) { placemarks, error in
                
                guard error == nil else {
                    print("* Error in \(#function): \(error!.localizedDescription)")
                    completion(nil)
                    return
                }
                
                guard let placemark = placemarks?[0] else {
                    print("* Error in \(#function): placemark is nil")
                    completion(nil)
                    return
                }
                
                guard let location = placemark.location else {
                    print("* Error in \(#function): placemark is nil")
                    return
                }
                completion(location)
            }
        }
}

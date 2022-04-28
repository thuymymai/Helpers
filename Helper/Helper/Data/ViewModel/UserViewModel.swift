//
//  UserViewModel.swift
//  Helper
//
//  Created by Dang Son on 17.4.2022.
//

import Foundation
import CoreData
import CoreLocation

class UserViewModel: ObservableObject {
    @Published var users: [UserModel] = []
    
    // saving Json to CoreData
    func saveData(context: NSManagedObjectContext) {
        users.forEach{ (data) in
            let entity = User(context: context)
            var long = 0.0
            var lat = 0.0
            entity.userId = (Int16) (data.userId!)
            entity.fullname = data.fullname
            entity.password = data.password
            entity.email = data.email
            entity.phone = data.phone
            entity.type = data.type
            entity.availability = data.availability
            entity.note = data.note
            entity.location = data.location
//            print("long is \(String(describing: data.long))")
//            print("long is in convert \((data.long! as NSString).doubleValue)")
            entity.long = (data.long! as NSString).doubleValue
            print("long is after convert \(String(format: "%.2f", entity.long))")
            entity.lat = (data.lat! as NSString).doubleValue
            entity.need = data.need
            entity.chronic = data.chronic
            entity.allergies = data.allergies

//            getLocation(forPlaceCalled: data.location!) { address in
//                guard let address = address else { return }
//
//                lat = address.coordinate.latitude
//                long = address.coordinate.longitude
//                print("long is in convert \(String(format: "%.2f", long))")
//            }
//
//            entity.lat = lat
//            entity.long = long
//            print("long is after convert \(String(format: "%.2f", entity.long))")
        }
        
        // saving all pending data at once
        do {
            try context.save()
            print("success saving users to core data")
        } catch {
            print(error)
        }
    }
    
    func fetchData(context: NSManagedObjectContext) {
        let url = "https://users.metropolia.fi/~sond/Swift%20Project/user.json"
        
        var request = URLRequest(url: URL(string: url)!)
        request.addValue("swiftUI", forHTTPHeaderField: "field")
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { (data, res, _) in
            guard let jsonData = data else{return}
            
            //cheking for any internal api error
            let response = res as! HTTPURLResponse
            
            // checking by status code
            if response.statusCode == 404 {
                print("error API error")
                return
            }
            
            // fetching JSON data
            do {
                let users = try JSONDecoder().decode([UserModel].self, from: jsonData)
                DispatchQueue.main.async {
                    self.users = users
                    self.saveData(context: context)
                }
            } catch {
                print(error)
            }
        }
        .resume()
    }
    
    func getLocation(forPlaceCalled name: String,
                     completion: @escaping(CLLocation?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(name) { placemarks, error in
            
            guard error == nil else {
                print("*** Error in \(#function) with \(name): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            
            guard let location = placemark.location else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }


            completion(location)
        }
    }

}

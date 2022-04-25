//
//  ContentView.swift
//  Helper
//
//  Created by SonDang, MyMai, AnHuynh on 1.4.2022.
//

import SwiftUI
import CoreData
import CoreLocationUI
import MapKit

struct ContentView: View {
    
    @StateObject var userModel = UserViewModel()
    @StateObject var taskModel = TaskViewModel()

    @Environment(\.managedObjectContext) var context
    
    // shared for next view
    static let shared = ContentView()
    
    // Constants for location
    var locationManager = LocationManager()
    
    // fetching user data from core data
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    
    // fetching task data from core data
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.title, ascending: true)]) var taskResults: FetchedResults<Task>
    
    func clearData(entityName: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        deleteRequest.resultType = .resultTypeObjectIDs
        do {
            let result = try context.execute(deleteRequest) as? NSBatchDeleteResult
            let objectIDArray = result?.result as? [NSManagedObjectID]
            let changes: [AnyHashable : Any] = [NSDeletedObjectsKey : objectIDArray as Any]
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
        } catch {
            print(error)
        }
//        do {
//            results.forEach{ (user) in
//                context.delete(user)
//            }
//            try context.save()
//        } catch {
//            print(error)
//        }
    }
    
    
    var body: some View {
        VStack{
            // clear core data in the beginning of the app
//            if !results.isEmpty {
//                ProgressView().onAppear(perform: {clearData(entityName: "User")})
////                ProgressView().onAppear(perform: {userModel.fetchData(context: context)})
//            }
//            if !taskResults.isEmpty {
//                ProgressView().onAppear(perform: {clearData(entityName: "Task")})
////                ProgressView().onAppear(perform: {taskModel.fetchData(context: context)})
//            }

            // checking if core data exists
            if results.isEmpty {
                if userModel.users.isEmpty {
                    ProgressView().onAppear(perform: {userModel.fetchData(context: context)})
                }
            } else {
                let _ = print("read user from core \(results.count) \(String(describing: results[results.count-1].email)) \(String(describing: results[results.count-1].password))")
                let _ = print("user \(results)")
            }
            if taskResults.isEmpty {
                if taskModel.tasks.isEmpty {
                    ProgressView().onAppear(perform: {taskModel.fetchData(context: context)})
                }
            } else {
                let _ = print("read task from core \(taskResults.count) \(String(describing: taskResults[taskResults.count-1].title)) \(String(describing: taskResults[taskResults.count-1].time))")
            }
            
        }
        LandingPage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

final class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{

    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40, longitude: 120), span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))

    let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    func requestAllowOnceLocationPermission(){
        locationManager.requestLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else {
            return
        }
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(center: latestLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            print("location is \(latestLocation.coordinate)")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

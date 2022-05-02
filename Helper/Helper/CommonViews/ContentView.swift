//
//  ContentView.swift
//  Helper
//
//  Created by Dang Son, My Mai, An Huynh on 1.4.2022.
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
    
    // Constants for location for getting current location
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
    }
    
    
    var body: some View {
        VStack{
//             clear core data in the beginning of the app
//            if !results.isEmpty {
//                ProgressView().onAppear(perform: {clearData(entityName: "User")})
////                ProgressView().onAppear(perform: {userModel.fetchData(context: context)})
//            }
//            if !taskResults.isEmpty {
//                ProgressView().onAppear(perform: {clearData(entityName: "Task")})
////                ProgressView().onAppear(perform: {taskModel.fetchData(context: context)})
//            }
            
            // checking if core data exists, if not fetch data from Network
            if results.isEmpty {
                if userModel.users.isEmpty {
                    ProgressView().onAppear(perform: {userModel.fetchData(context: context)})
                }
            }
            
            if taskResults.isEmpty {
                if taskModel.tasks.isEmpty {
                    ProgressView().onAppear(perform: {taskModel.fetchData(context: context)})
                }
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

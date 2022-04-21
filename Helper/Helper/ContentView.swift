//
//  ContentView.swift
//  Helper
//
//  Created by SonDang, MyMai, AnHuynh on 1.4.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @StateObject var userModel = UserViewModel()
    @StateObject var taskModel = TaskViewModel()

    @Environment(\.managedObjectContext) var context
    
    // fetching user data from core data
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    
    // fetching task data from core data
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.title, ascending: true)]) var taskResults: FetchedResults<Task>
    
    func resetUser() {
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//        deleteRequest.resultType = .resultTypeObjectIDs
//        do {
//            let result = try context.execute(deleteRequest) as? NSBatchDeleteResult
//            let objectIDArray = result?.result as? [NSManagedObjectID]
//            let changes: [AnyHashable : Any] = [NSDeletedObjectsKey : objectIDArray as Any]
//            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
//        } catch {
//            print(error)
//        }
        do {
            results.forEach{ (user) in
                context.delete(user)
            }
            try context.save()
        } catch {
            print(error)
        }
        
        
    }
    
    var body: some View {
        VStack{
            // clear core data in the beginning of the app
//            if !results.isEmpty {
//                ProgressView().onAppear(perform: {resetUser()})
////                ProgressView().onAppear(perform: {userModel.fetchData(context: context)})
//            }

            // checking if core data exists
            if results.isEmpty {
                if userModel.users.isEmpty {
                    ProgressView().onAppear(perform: {userModel.fetchData(context: context)})
                }
            } else {
                let _ = print("read from core \(results.count) \(results[results.count-1].email) \(results[results.count-1].password)")
            }
//
        }
        LandingPage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

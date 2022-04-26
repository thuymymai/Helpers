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
//             clear core data in the beginning of the app
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

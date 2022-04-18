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
    @Environment(\.managedObjectContext) var context
    
    // fetching data from core data
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.user_id, ascending: true)]) var results: FetchedResults<User>
    
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
//        VStack{
//            // clear core data in the beginning of the app
//            if !results.isEmpty {
//                ProgressView().onAppear(perform: {clearData(entityName: "User")})
//            }
//
//            // checking if core data exists
//            if results.isEmpty {
//                if userModel.users.isEmpty {
//                    ProgressView().onAppear(perform: {userModel.fetchData(context: context)})
//                } else {
//                    List(userModel.users, id: \.self) {user in
//                        Text(user.username!)
//                    }
//                }
//            } else {
//                let _ = print("read from core \(results[1].age)")
//            }
//
//        }
        LandingPage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  Persistence.swift
//  Helper
//
//  Created by Dang Son on 18.4.2022.
//

import Foundation
import CoreData

struct PersistenceController {
    // A singleton for our entire app to use
    static let shared = PersistenceController()
    
    // Storage for Core Data
    let container: NSPersistentContainer
    
//    static var preview: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
////        let viewContext = result.container.viewContext
////        for _ in 0..<10 {
////            let newItem = User(context: viewContext)
////            newItem.timestamp = Date()
////        }
//        return result
//    }()
    
    init(inMemory: Bool = false) {
        // If you didn't name your model Main you'll need
        // to change this name below.
        container = NSPersistentContainer(name: "UserData")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Show some error here
                print(error)
            }
        }
    }
}

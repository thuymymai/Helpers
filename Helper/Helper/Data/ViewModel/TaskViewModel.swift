//
//  TaskViewModel.swift
//  Helper
//
//  Created by Mai Thuỳ My on 20.4.2022.
//

import Foundation
import CoreData

class TaskViewModel: ObservableObject {
    @Published var tasks: [TaskModel] = []
    
    // saving Json to CoreData
    func saveData(context: NSManagedObjectContext) {
        tasks.forEach{ (data) in
            let entity = Task(context: context)
            entity.title = data.title
            entity.location = data.location
            entity.long = (data.long! as NSString).doubleValue
            entity.lat = (data.lat! as NSString).doubleValue
            entity.time = DateFormatter().date(from: data.time!)
            entity.category = data.category
            entity.desc = data.description
            entity.volunteer = (Int16) (data.volunteer!)
            entity.helpseeker = (Int16) (data.helpseeker!)
        }
        
        // saving all pending data at once
        do {
            try context.save()
            print("success saving to core data")
        } catch {
            print(error)
        }
    }
    
    func fetchData(context: NSManagedObjectContext) {
        let url = "https://users.metropolia.fi/~sond/Swift%20Project/task.json"
        
        var request = URLRequest(url: URL(string: url)!)
        request.addValue("swiftUI-task", forHTTPHeaderField: "field")
        
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
                let tasks = try JSONDecoder().decode([TaskModel].self, from: jsonData)
                DispatchQueue.main.async {
                    self.tasks = tasks
                    self.saveData(context: context)
                }
            } catch {
                print(error)
            }
        }
        .resume()
    }
    
}

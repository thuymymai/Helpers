//
//  UserViewModel.swift
//  Helper
//
//  Created by Dang Son on 17.4.2022.
//

import Foundation
import CoreData

class UserViewModel: ObservableObject {
    @Published var users: [UserModel] = []
    
    // saving Json to CoreData
    func saveData(context: NSManagedObjectContext) {
        users.forEach{ (data) in
            let entity = User(context: context)
            entity.user_id = (Int16) (data.user_id!)
            entity.username = data.username
            entity.password = data.password
            entity.email = data.email
            entity.phone = data.phone
            entity.type = data.type
            entity.driving = data.driving
            entity.coordinating = data.coordinating
            entity.coaching = data.coaching
            entity.programing = data.programing
            entity.often = data.often
            entity.age = (Int16) (data.age!) ?? 0
            entity.weight = (Int16) (data.weight!) ?? 0
            entity.height = (Int16) (data.height!) ?? 0
            entity.need = data.need
            entity.cronic = data.cronic
            entity.allergies = data.allergies
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
}

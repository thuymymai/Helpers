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
//    func saveData(context: NSManagedObjectContext) {
//        users.forEach{ (data) in
//            let entity = User(context: context)
//            entity
//        }
//    }
    
    func fetchData() {
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
                }
            } catch {
                print(error)
            }
        }
        .resume()
    }
}

//
//  UserData.swift
//  Helper
//
//  Created by Dang Son on 10.4.2022.
//

import SwiftUI
import CoreData

struct UserData {
    func updateUserDataFromNetwork(context: NSManagedObjectContext) {
        let urlUser = "https://users.metropolia.fi/~sond/Swift%20Project/user.json"
        
        guard let url = URL(string: urlUser) else {
            print("bad URL")
            return
            
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("data task error: \(error.localizedDescription)")
                return
            } else {
                guard let response = response else {
                    print("bad response")
                    return
                }
                print("response: \(response.expectedContentLength)")
                if let data = data {
                    do {
//                        let decoder = JSONDecoder()
//                        let userData = try JSO([User].self, from: data)
                        let userData = try JSONSerialization.jsonObject(with: data, options: [])
                        print("array: \(userData)")
//                        print("array length: \(userData.count)")
                        
                        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy //
                        
//                        userData.forEach{user in
//                            let usero = User(context: context)
//                            usero.user_id = Int16(user.user_id)
//                            usero.username = user.username
//                            usero.password = user.password
//                            usero.email = user.email
//                            usero.phone = user.phone
//                            usero.type = user.type
//                            usero.driving = user.driving
//                            usero.coordinating = user.coordinating
//                            usero.coaching = user.coaching
//                            usero.programming = user.programming
//                            usero.often = user.often
//                            usero.age = user.age
//                            usero.weight = user.weight
//                            usero.height = user.height
//                            usero.need = user.need
//                            usero.cronic = user.cronic
//                            usero.allergies = user.allergies
//                        }
                        
                        try context.save()
                    } catch let err {
                        print("err: \(err)")
                    }
                }
            }
        }
        task.resume()
    }
}

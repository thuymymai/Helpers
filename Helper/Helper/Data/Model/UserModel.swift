//
//  UserModel.swift
//  Helper
//
//  Created by Dang Son on 17.4.2022.
//

import Foundation

struct UserModel: Decodable, Hashable {

    // define variables
    let userId: Int?
    let fullname: String?
    let password: String?
    let email: String?
    let phone: String?
    let type: String?
    let availability: String?
    let note: String?
    let location: String?
    let long: String?
    let lat: String?
    let need: String?
    let chronic: String?
    let allergies: String?
   
    
        
    // define the coding keys
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case fullname = "username"
        case password = "password"
        case email = "email"
        case phone = "phone"
        case type = "type"
        case availability = "availability"
        case note = "note"
        case location = "location"
        case long = "long"
        case lat = "lat"
        case need = "need"
        case chronic = "chronic"
        case allergies = "allergies"
    }
        
    // initialize all values
    init(from decoder: Decoder) throws {
        // get the container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // get the values
        userId = try container.decodeIfPresent(Int.self, forKey: .userId)
        fullname = try container.decodeIfPresent(String.self, forKey: .fullname)
        password = try container.decodeIfPresent(String.self, forKey: .password)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        availability = try container.decodeIfPresent(String.self, forKey: .availability)
        note = try container.decodeIfPresent(String.self, forKey: .note)
        location = try container.decodeIfPresent(String.self, forKey: .location)
        long = try container.decodeIfPresent(String.self, forKey: .long)
        lat = try container.decodeIfPresent(String.self, forKey: .lat)
        need = try container.decodeIfPresent(String.self, forKey: .need)
        chronic = try container.decodeIfPresent(String.self, forKey: .chronic)
        allergies = try container.decodeIfPresent(String.self, forKey: .allergies)
    }
}

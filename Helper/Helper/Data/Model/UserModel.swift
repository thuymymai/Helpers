//
//  UserModel.swift
//  Helper
//
//  Created by Dang Son on 17.4.2022.
//

import Foundation

struct UserModel: Decodable, Hashable {

    // define variables
    let user_id: Int?
    let username: String?
    let password: String?
    let email: String?
    let phone: String?
    let type: String?
    let driving: String?
    let coordinating: String?
    let coaching: String?
    let programing: String?
    let often: String?
    let age: String?
    let weight: String?
    let height: String?
    let need: String?
    let cronic: String?
    let allergies: String?
        
    // define the coding keys
    enum CodingKeys: String, CodingKey {
        case user_id = "user_id"
        case username = "username"
        case password = "password"
        case email = "email"
        case phone = "phone"
        case type = "type"
        case driving = "driving"
        case coordinating = "coordinating"
        case coaching = "coaching"
        case programing = "programing"
        case often = "often"
        case age = "age"
        case weight = "weight"
        case height = "height"
        case need = "need"
        case cronic = "cronic"
        case allergies = "allergies"
    }
        
    // initialize all values
    init(from decoder: Decoder) throws {
        // get the container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // get the values
        user_id = try container.decodeIfPresent(Int.self, forKey: .user_id)
        username = try container.decodeIfPresent(String.self, forKey: .username)
        password = try container.decodeIfPresent(String.self, forKey: .password)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        driving = try container.decodeIfPresent(String.self, forKey: .driving)
        coordinating = try container.decodeIfPresent(String.self, forKey: .coordinating)
        coaching = try container.decodeIfPresent(String.self, forKey: .coaching)
        programing = try container.decodeIfPresent(String.self, forKey: .programing)
        often = try container.decodeIfPresent(String.self, forKey: .often)
        age = try container.decodeIfPresent(String.self, forKey: .age)
        weight = try container.decodeIfPresent(String.self, forKey: .weight)
        height = try container.decodeIfPresent(String.self, forKey: .height)
        need = try container.decodeIfPresent(String.self, forKey: .need)
        cronic = try container.decodeIfPresent(String.self, forKey: .cronic)
        allergies = try container.decodeIfPresent(String.self, forKey: .allergies)
    }
}

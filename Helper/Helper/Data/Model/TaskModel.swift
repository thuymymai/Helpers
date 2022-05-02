//
//  TaskModel.swift
//  Helper
//
//  Created by Mai My, Dang Son, An Huynh on 20.4.2022.
//

import Foundation

struct TaskModel: Decodable, Hashable {

    // define variables
    let id: Int?
    let title: String?
    let location: String?
    let long: String?
    let lat: String?
    let time: String?
    let category: String?
    let description: String?
    let status: Int?
    let volunteer: Int?
    let helpseeker: Int?

    // define the coding keys
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case location = "location"
        case long = "long"
        case lat = "lat"
        case time = "time"
        case category = "category"
        case description = "description"
        case status = "status"
        case volunteer = "volunteer"
        case helpseeker = "help seeker"
    }
        
    // initialize all values
    init(from decoder: Decoder) throws {
        // get the container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // get the values
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        location = try container.decodeIfPresent(String.self, forKey: .location)
        long = try container.decodeIfPresent(String.self, forKey: .long)
        lat = try container.decodeIfPresent(String.self, forKey: .lat)
        time = try container.decodeIfPresent(String.self, forKey: .time)
        category = try container.decodeIfPresent(String.self, forKey: .category)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        status = try container.decodeIfPresent(Int.self, forKey: .status)
        volunteer = try container.decodeIfPresent(Int.self, forKey: .volunteer)
        helpseeker = try container.decodeIfPresent(Int.self, forKey: .helpseeker)
    }
}

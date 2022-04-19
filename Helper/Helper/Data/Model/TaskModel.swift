//
//  TaskModel.swift
//  Helper
//
//  Created by Mai Thuỳ My on 20.4.2022.
//

import Foundation

struct TaskModel: Decodable, Hashable {

    // define variables
    let title: String?
    let location: String?
    let time: String?
    let category: String?
    let description: String?
    let volunteer: Int?
    let helpseeker: Int?

    // define the coding keys
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case location = "Location"
        case time = "Time"
        case category = "Category"
        case description = "Description"
        case volunteer = "Volunteer"
        case helpseeker = "Help seeker"
    }
        
    // initialize all values
    init(from decoder: Decoder) throws {
        // get the container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // get the values
        title = try container.decodeIfPresent(String.self, forKey: .title)
        location = try container.decodeIfPresent(String.self, forKey: .location)
        time = try container.decodeIfPresent(String.self, forKey: .time)
        category = try container.decodeIfPresent(String.self, forKey: .category)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        volunteer = try container.decodeIfPresent(Int.self, forKey: .volunteer)
        helpseeker = try container.decodeIfPresent(Int.self, forKey: .helpseeker)
    }
}
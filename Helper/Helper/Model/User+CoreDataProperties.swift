//
//  User+CoreDataProperties.swift
//  Helper
//
//  Created by Dang Son on 10.4.2022.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var user_id: Int16
    @NSManaged public var username: String?
    @NSManaged public var password: String?
    @NSManaged public var email: String?
    @NSManaged public var phone: String?
    @NSManaged public var type: String?
    @NSManaged public var driving: String?
    @NSManaged public var coordinating: String?
    @NSManaged public var coaching: String?
    @NSManaged public var programming: String?
    @NSManaged public var often: String?
    @NSManaged public var age: String?
    @NSManaged public var weight: String?
    @NSManaged public var height: String?
    @NSManaged public var need: String?
    @NSManaged public var cronic: String?
    @NSManaged public var allergies: String?
    @NSManaged public var task_help: Task?
    @NSManaged public var tasl_helper: Task?

}

extension User : Identifiable {

}

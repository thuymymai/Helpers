//
//  Task+CoreDataProperties.swift
//  Helper
//
//  Created by Dang Son on 10.4.2022.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var title: String?
    @NSManaged public var location: String?
    @NSManaged public var time: Date?
    @NSManaged public var category: String?
    @NSManaged public var desc: String?
    @NSManaged public var help_seeker: Int16
    @NSManaged public var volunteer: Int16

}

extension Task : Identifiable {

}

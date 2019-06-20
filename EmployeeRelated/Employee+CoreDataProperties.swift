//
//  Employee+CoreDataProperties.swift
//  NoonAcademyTask
//
//  Created by Mithilesh Singh on 25/05/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var name: String?
    @NSManaged public var email_id: String?
    @NSManaged public var city: String?
    @NSManaged public var married: Bool
    @NSManaged public var aniversary_date: NSDate?

}

extension Employee: EmployeeDetailProtocol {
}

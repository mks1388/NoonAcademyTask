//
//  DataInteractor.swift
//  NoonAcademyTask
//
//  Created by Mithilesh Singh on 25/05/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import Foundation
import CoreData

class DataInteractor {
    func saveData(name: String, email: String, city: String, isMarried: Bool, aniversaryDate: Date?) {
        CoreDataStack.shared.persistentContainer.viewContext.performAndWait {
            // Create new records.
            let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
            let namePredicate = NSPredicate(format: "name=%@", name)
            let emailPredicate = NSPredicate(format: "email_id=%@", email)
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [namePredicate, emailPredicate])
            var empData: Employee? = nil
            do{
                let arrEmployee = try CoreDataStack.shared.persistentContainer.viewContext.fetch(fetchRequest)
                if arrEmployee.count <= 0 {
                    guard let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: CoreDataStack.shared.persistentContainer.viewContext) as? Employee else {
                        print("Error: Failed to create a new Employee Data object!")
                        return
                    }
                    empData = employee
                } else {
                    empData = arrEmployee[0]
                }
            } catch {
                print("Error: Failed to update a Employee Data object!")
            }
            guard let employeeData = empData else {
                return
            }
            
            employeeData.name = name
            employeeData.email_id = email
            employeeData.city = city
            employeeData.married = isMarried
            employeeData.aniversary_date = aniversaryDate as NSDate?
            
            CoreDataStack.shared.saveContext()
        }
    }
}

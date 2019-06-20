//
//  CoreDataStack.swift
//  NoonAcademyTask
//
//  Created by Mithilesh Singh on 25/05/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import UIKit
import CoreData

class CoreDataStack: NSObject {
    private static let moduleName = "NoonAcademyTask"
    
    static let shared = CoreDataStack()
    
    private override init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataStack.moduleName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

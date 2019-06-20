//
//  EmployeeTableViewController.swift
//  NoonAcademyTask
//
//  Created by Mithilesh Singh on 25/05/19.
//  Copyright © 2019 Mithilesh Kumar Singh. All rights reserved.
//

import UIKit
import CoreData

class EmployeeTableViewController: UITableViewController {

    private var fetchResultsController: NSFetchedResultsController<Employee>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialiseFetchedResultsController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = "Employee List"
    }

    //MARK: Private
    private func initialiseFetchedResultsController() {
        let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
        
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        
        fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchResultsController.delegate = self
        
        do {
            try fetchResultsController.performFetch()
        } catch {
            print("Error during fetching data: \(error)")
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? EmployeeDetailViewController, let cell = sender as? UITableViewCell else {
            return
        }
        
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        let employee = fetchResultsController.object(at: indexPath)
        vc.employee = employee
    }
}

//MARK: NSFetchedResultsControllerDelegate
extension EmployeeTableViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        tableView.reloadData()
    }
}

//MARK: UITableViewDataSource
extension EmployeeTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeCell.identifier, for: indexPath)
        guard let employeeCell = cell as? EmployeeCell  else {
            return cell
        }
        
        let employee = fetchResultsController.object(at: indexPath)

        employeeCell.textLabel?.text = employee.name
        employeeCell.detailTextLabel?.text = employee.email_id
        
        return employeeCell
    }
}

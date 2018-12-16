//
//  TableViewController.swift
//  TeamBlack
//
//  Created by OSU App Center on 11/10/18.
//  Copyright © 2018 Oklahoma State University. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    // Declaration of variables and UI Objects
    var dataSource: [Expense] = []
    var appDelegate: AppDelegate?
    var context: NSManagedObjectContext?
    var entity: NSEntityDescription?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        context = appDelegate?.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "Expenses", in: context!)
        
        DatabaseHelper.getExpenses(self)
    }
    
    @IBAction func unwindFromSubmit(segue: UIStoryboardSegue) {
        guard let source = segue.source as? DataEntryViewController else {
            print("Cannot get unwind segue source")
            return
        }
        
        DatabaseHelper.getExpenses(self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // Number of records in table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.count
    }

    // Populates the table with data source entries.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "My Cell", for: indexPath)
        
        cell.textLabel?.text = dataSource[indexPath.row].description
        cell.detailTextLabel?.text = dataSource[indexPath.row].category
        
        // Configure the cell...

        return cell
    }
 
    //datasource fetches the value from course entity and displays it when ever the view will appear happens.
    override func viewWillAppear(_ animated: Bool) {
    }
    
    // edit record appears when ever a cell got clicked
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            
            UserVariables.expenseToEdit = dataSource[indexPath.row]
            
            // EditTask
            self.performSegue(withIdentifier: "EditTask", sender: self)
        }
    }
    
    // Delete option on every cell
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // To delete any any record.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "My Cell", for: indexPath)
        if (editingStyle == .delete) {
            
            DatabaseHelper.deleteExpense(dataSource[indexPath.row], self)
            DatabaseHelper.getExpenses(self)
            tableView.reloadData()
        }
    }
    
    // called when the database has fetched expenses belonging to the User
    func loadListWith(_ expenses: [Expense]) {
        
        dataSource.removeAll()
        
        for e in expenses {
            dataSource.append(e)
        }
            
        tableView.reloadData()
    }
}

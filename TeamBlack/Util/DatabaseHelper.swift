//
//  DatabaseHelper.swift
//  TeamBlack
//
//  Created by Clifford Kyle Jarrell on 11/13/18.
//  Copyright © 2018 Oklahoma State University. All rights reserved.
//

import Foundation

// Operations to make API calls to php files that interact with a database, and return JSON or response text.

struct DatabaseHelper {
    
    // Database info
    static let passwordDb = ""
	// php hash of DB password
    static let hashDb = ""
	// server hosting the php files
    static let urlString = "" + "/index.php/" + passwordDb
    
    // php fileNames
    static let filenameReadAuthentication = "read_authentication"
    static let filenameReadExpenses = "read_expenses"
    static let filenameAddExpense = "add_expense"
    static let filenameDeleteExpense = "delete_expense"
    static let filenameEditExpense = "edit_expense"
    
    
    // Search for username in the database and check password
    // Store variables in global UserVariables if authenticated
    static func authenticate(_ user: String, _ pass: String, _ vcInstance: ViewController) {
        
        // check if valid URL
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // create and customize request with POST data
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let params: [String : String] = ["filename" : filenameReadAuthentication,
                                          "username_entered" : user,
                                          "password_entered" : pass]
        let postString = buildPostString(params)
        request.httpBody = postString.data(using: .utf8)
        
        // used to store the returned database row
        struct User: Decodable{
            
            // variables names same as attribute names in the database
            let uidUsers: String
            let emailUsers: String
            let propertyID: String
            let pwdUsers: String
        }
        
        // The method dataTask(with:) specifies a completion closure;
        // it is invoked asynchronously when the call to the service returns.
        let task = URLSession.shared.dataTask(with: request ) { (data, response, error) in
            
            // Check to see if any error was encountered.
            guard error == nil else {
                print("URL Session error: \(error!)")
                return
            }
            
            // Check to see if we received any data.
            guard let data = data else{
                print("No data received")
                return
            }
            
            // gets response in the form of JSON data (single json object representing db row returned)
            do {let json = try JSONDecoder().decode(User.self, from: data)
                
                // set global variables for the authenticated User
                UserVariables.setUserVariables(json.uidUsers, json.emailUsers, json.propertyID, json.pwdUsers)
                
                // update the view on the main thread
                DispatchQueue.main.async {
                    // perform segue to expenses list
                    vcInstance.goToNextView()
                }
                
            // If no JSON, then invalid credentials
            } catch let error as NSError {
                print("Error serializing JSON Data: \(error)")
                
                // Display message to the user and do not segue
                DispatchQueue.main.async {
                    Functions.showAlert("Invalid Username or Password", vcInstance)
                }
                
            }
            
        }
        
        // execute the task
        task.resume();
    }
    
    
    // retrieve a list of expenses based on the authenticated user's id
    static func getExpenses(_ vcInstance: TableViewController) {
        
        // check if valid URL
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // create and customize request with POST data
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let params: [String : String] = ["filename" : filenameReadExpenses,
                                         "propertyID" : UserVariables.propertyID]
        let postString = buildPostString(params)
        request.httpBody = postString.data(using: .utf8)
        
        
        // create array to hold expense objects
        var expenses: [Expense] = []
    
        
        // The method dataTask(with:) specifies a completion closure;
        // it is invoked asynchronously when the call to the service returns.
        let task = URLSession.shared.dataTask(with: request ) { (data, response, error) in
            
            // Check to see if any error was encountered.
            guard error == nil else {
                print("URL Session error: \(error!)")
                return
            }
            
            // Check to see if we received any data.
            guard let data = data else{
                print("No data received")
                return
            }
            
            // gets response in the form of JSON data (array of objects)
            do {let jsonArray = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSMutableArray
                
                // Looping through jsonArray
                for jsonObject in jsonArray as! [Dictionary<String, Any>] {
                    let e = Expense(jsonObject["propertyID"] as! String
                        , jsonObject["description"] as! String
                        , jsonObject["urgent"] as! String
                        , jsonObject["important"] as! String
                        , jsonObject["category"] as! String
                        , (jsonObject["estimated_cost"] as! NSString).doubleValue
                        , jsonObject["estimated_based_on"] as! String
                        , jsonObject["note"] as! String
                        , jsonObject["hidden"] as! String
                        , jsonObject["completed"] as! String)
                    
                    expenses.append(e)
                }
                
                // load the tableview with the list of fetched expenses
                vcInstance.loadListWith(expenses)
                
            } catch let error as NSError {
                print("Error with parsing JSON: \(error)")
                
                DispatchQueue.main.async {
                    Functions.showAlert("Error fetching expenses from the database", vcInstance)
                }
                
            }
            
        }
 
        
        // execute the task
        task.resume();
    }
    
    // add expense to the database
    static func addExpense(_ expense: Expense, _ vcInstance: DataEntryViewController) {
        
        // check if valid URL
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // create and customize request with POST data
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let params: [String : String] = ["filename" : filenameAddExpense,
                                         "propertyID" : expense.propertyID,
                                         "description" : expense.description,
                                         "urgent" : expense.urgent,
                                         "important" : expense.important,
                                         "category" : expense.category,
                                         "estimated_cost" : String(expense.estimated_cost),
                                         "estimated_based_on" : expense.estimated_based_on,
                                         "note" : expense.note,
                                         "hidden" : expense.hidden,
                                         "completed" : expense.completed]
        let postString = buildPostString(params)
        request.httpBody = postString.data(using: .utf8)
        
        
        // The method dataTask(with:) specifies a completion closure;
        // it is invoked asynchronously when the call to the service returns.
        let task = URLSession.shared.dataTask(with: request ) { (data, response, error) in
            
            // Check to see if any error was encountered.
            guard error == nil else {
                print("URL Session error: \(error!)")
                return
            }
            
            // Check to see if we received any data.
            guard let data = data else{
                print("No data received")
                return
            }

            /*
             // MARK: code to perform when no error in adding expense
             // Assume rows will always be added successfully. This is just for extra credit.
             // gets raw response string echoed through the php
             let responseString = String(data: data, encoding: .utf8)!
             
             if (responseString == "error") {
             DispatchQueue.main.async {
             //Functions.showAlert("Error deleting expense", vcInstance)
             }
             }
             else {
             // update the view on the main thread
             DispatchQueue.main.async {
             vcInstance.goToNextView()
             }
             */
        }
        
        task.resume()
    }
    
    // first parameter is the id of the expense, in this case, it is every attribute of the expense.
    static func deleteExpense(_ expense: Expense, _ vcInstance: TableViewController) {
        // check if valid URL
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // create and customize request with POST data
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let params: [String : String] = ["filename" : filenameDeleteExpense,
                                         "propertyID" : expense.propertyID,
                                         "description" : expense.description,
                                         "urgent" : expense.urgent,
                                         "important" : expense.important,
                                         "category" : expense.category,
                                         "estimated_cost" : String(expense.estimated_cost),
                                         "estimated_based_on" : expense.estimated_based_on,
                                         "note" : expense.note,
                                         "hidden" : expense.hidden,
                                         "completed" : expense.completed]
        let postString = buildPostString(params)
        request.httpBody = postString.data(using: .utf8)

        
        // The method dataTask(with:) specifies a completion closure;
        // it is invoked asynchronously when the call to the service returns.
        let task = URLSession.shared.dataTask(with: request ) { (data, response, error) in
            
            // Check to see if any error was encountered.
            guard error == nil else {
                print("URL Session error: \(error!)")
                return
            }
            
            // Check to see if we received any data.
            guard let data = data else{
                print("No data received")
                return
            }
            
            /*
             // MARK: code to perform when no error in deleting expense
             // Assume rows will always be added successfully. This is just for extra credit.
             // gets raw response string echoed through the php
             let responseString = String(data: data, encoding: .utf8)!
             
             if (responseString == "error") {
             DispatchQueue.main.async {
             //Functions.showAlert("Error deleting expense", vcInstance)
             }
             }
             else {
             // update the view on the main thread
             DispatchQueue.main.async {
             vcInstance.goToNextView()
             }
             */
        }
        
        // execute the task
        task.resume()
    }
    
    // first parameter is to identify the expense to replace with the second parameter expense
    static func editExpense(_ expense: Expense, _ updatedExpense: Expense, _ vcInstance: DisplayDataViewController) {
        // check if valid URL
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // create and customize request with POST data
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let params: [String : String] = ["filename" : filenameEditExpense,
                                         "propertyID" : expense.propertyID,
                                         "description" : expense.description,
                                         "urgent" : expense.urgent,
                                         "important" : expense.important,
                                         "category" : expense.category,
                                         "estimated_cost" : String(expense.estimated_cost),
                                         "estimated_based_on" : expense.estimated_based_on,
                                         "note" : expense.note,
                                         "hidden" : expense.hidden,
                                         "completed" : expense.completed,
                                         "update_propertyID" : updatedExpense.propertyID,
                                         "update_description" : updatedExpense.description,
                                         "update_urgent" : updatedExpense.urgent,
                                         "update_important" : updatedExpense.important,
                                         "update_category" : updatedExpense.category,
                                         "update_estimated_cost" : String(updatedExpense.estimated_cost),
                                         "update_estimated_based_on" : updatedExpense.estimated_based_on,
                                         "update_note" : updatedExpense.note,
                                         "update_hidden" : updatedExpense.hidden,
                                         "update_completed" : updatedExpense.completed]
        let postString = buildPostString(params)
        request.httpBody = postString.data(using: .utf8)
        
        
        // The method dataTask(with:) specifies a completion closure;
        // it is invoked asynchronously when the call to the service returns.
        let task = URLSession.shared.dataTask(with: request ) { (data, response, error) in
            
            // Check to see if any error was encountered.
            guard error == nil else {
                print("URL Session error: \(error!)")
                return
            }
            
            // Check to see if we received any data.
            guard let data = data else{
                print("No data received")
                return
            }
            
            /*
            // MARK: code to perform when no error in editing expense
            // Assume rows will always be updated successfully. This is just for extra credit.
            // gets raw response string echoed through the php
            let responseString = String(data: data, encoding: .utf8)!
            
            if (responseString == "error") {
                DispatchQueue.main.async {
                    //Functions.showAlert("Error deleting expense", vcInstance)
                }
            }
             else {
             // update the view on the main thread
             DispatchQueue.main.async {
                vcInstance.goToNextView()
             }
             */
        }
        
        task.resume()
    }
    
    // Construct the string of POST variables to send
    // we always need to pass the password_db, hash_db and filename POST variabless
    // other values are needed depending on the operation
    static func buildPostString(_ params: [String : String]) -> String {
    
        var result = "password_db=" + passwordDb + "&hash_db=" + hashDb;
        
        for entry in params {
            result += "&" + entry.key + "=" + entry.value
        }
        
        return result
    }
}

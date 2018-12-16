//
//  Expense.swift
//  TeamBlack
//
//  Created by Clifford Kyle Jarrell on 11/13/18.
//  Copyright © 2018 Oklahoma State University. All rights reserved.
//

import Foundation

class Expense {
    
    // variables names same as attribute names in the database
    let propertyID: String
    let description: String
    let urgent: String
    let important: String
    let category: String
    let estimated_cost: Double
    let estimated_based_on: String
    let note: String
    let hidden: String
    let completed: String
    
    // Constructor to use the Expense table
    init(_ propertyID: String, _ description: String, _ urgent: String, _ important: String, _ category: String, _ estimated_cost: Double, _ estimated_based_on: String, _ note: String, _ hidden: String, _ completed:String) {
        
        self.propertyID = propertyID
        self.description = description
        self.urgent = urgent
        self.important = important
        self.category = category
        self.estimated_cost = estimated_cost
        self.estimated_based_on = estimated_based_on
        self.note = note
        self.hidden = hidden
        self.completed = completed
    }
    
    // constructor for the static expense to edit
    // allows passing through segue
    init() {
        self.propertyID = ""
        self.description = ""
        self.urgent = ""
        self.important = ""
        self.category = ""
        self.estimated_cost = 0.0
        self.estimated_based_on = ""
        self.note = ""
        self.hidden = ""
        self.completed = ""
    }
}

//
//  User.swift
//  TeamBlack
//
//  Created by Clifford Kyle Jarrell on 11/13/18.
//  Copyright © 2018 Oklahoma State University. All rights reserved.
//

import Foundation

// Access these global variables in the application once user is authenticated

struct UserVariables {
    
    // The expense that user wants to edit
    static var expenseToEdit = Expense()
    
    // Declaration of variables.
    static var uidUsers = ""
    static var emailUsers = ""
    static var propertyID = ""
    static var pwdUsers = ""
    
    // init methos with 4 arguments for login.
    static func setUserVariables (_ uidUsers: String, _ emailUsers: String, _ propertyID: String, _ pwdUsers: String) {
        UserVariables.uidUsers = uidUsers
        UserVariables.emailUsers = emailUsers
        UserVariables.propertyID = propertyID
        UserVariables.pwdUsers = pwdUsers
    }
}

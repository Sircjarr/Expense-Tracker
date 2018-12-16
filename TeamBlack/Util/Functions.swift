//
//  Functions.swift
//  TeamBlack
//
//  Created by Clifford Kyle Jarrell on 11/13/18.
//  Copyright © 2018 Oklahoma State University. All rights reserved.
//

import Foundation
import UIKit

// global helper functions

struct Functions {

    // generates simple alert dialog with a given message
    static func showAlert(_ message: String, _ instance: UIViewController) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(okAction)  // Present the alert controller to the user.
        instance.present(alertController, animated: true, completion: nil)
    }
}

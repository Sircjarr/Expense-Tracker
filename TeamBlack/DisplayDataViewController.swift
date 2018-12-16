//
//  DisplayDataViewController.swift
//  TeamBlack
//
//  Created by OSU App Center on 11/10/18.
//  Copyright © 2018 Oklahoma State University. All rights reserved.
//

import UIKit

class DisplayDataViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Declaration of UI Objects and variables.
    @IBOutlet weak var description_expenses: UITextView!
    @IBOutlet weak var estimatedCost: UITextField!
    @IBOutlet weak var note: UITextField!
    @IBOutlet weak var urgencyPickerView: UIPickerView!
    @IBOutlet weak var importancePickerView: UIPickerView!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var estimatesBasedOnPickerView: UIPickerView!
    @IBOutlet weak var urgencyTypeSelected: UIButton!
    @IBOutlet weak var importanceTypeSelected: UIButton!
    @IBOutlet weak var categoryTypeSelected: UIButton!
    @IBOutlet weak var estimatesBasedOnTypeSelected: UIButton!
    
    var urgencyPickerType = ["Select type of urgency", "Urgent", "Not Urgent"]
    var importancePickerType = ["Select type of importance", "Important", "Not Important"]
    var categoryPickerType = ["Select type of category", "OPEX", "CAPEX", "Other"]
    var estimatesBasedOnPickerType = ["Select type of estimates based on", "One Bid", "Multiple Bids", "Online Research", "Past knowledge", "Educated guess", "Other"]
    var urgencyTitle = String()
    var importanceTitle = String()
    var categoryTitle = String()
    var estimatesBasedOnTitle = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Textfield delegates and datasource
        urgencyPickerView.dataSource = self
        urgencyPickerView.delegate=self;
        
        importancePickerView.dataSource = self;
        importancePickerView.delegate=self;
        
        categoryPickerView.dataSource = self;
        categoryPickerView.delegate=self;
        
        estimatesBasedOnPickerView.dataSource = self;
        estimatesBasedOnPickerView.delegate=self;
        
        note.delegate = self
        
        // load the fields with the expenseToEdit
        description_expenses.text = UserVariables.expenseToEdit.description
        estimatedCost.text = String(UserVariables.expenseToEdit.estimated_cost)
        note.text = UserVariables.expenseToEdit.note
        
        
        /*
        urgencyPickerView.text = UserVariables.expenseToEdit.description
        importancePickerView.text = UserVariables.expenseToEdit.description
        categoryPickerView.text = UserVariables.expenseToEdit.description
        estimatesBasedOnPickerView.text = UserVariables.expenseToEdit.description
         */
        
        /*
        urgencyTypeSelected.text = UserVariables.expenseToEdit.description
        importanceTypeSelected.text = UserVariables.expenseToEdit.description
        categoryTypeSelected.text = UserVariables.expenseToEdit.description
        estimatesBasedOnTypeSelected.text = UserVariables.expenseToEdit.description
         */
    }
    
    // Number of Picker view components.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Number of rows in each picker view component
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return urgencyPickerType.count
        } else if pickerView.tag == 2 {
            return importancePickerType.count
        } else if pickerView.tag == 3 {
            return categoryPickerType.count
        } else {
            return estimatesBasedOnPickerType.count
        }
    }
    
    // Submit button saves the data and return to table view.
    @IBAction func submitTouched(_ sender: Any) {
        performSegue(withIdentifier: "unwindFromSave", sender: nil)
    }
    
    // Urgency Button shows the value of urgency picker view value.
    @IBAction func urgencyTypeTouched(_ sender: Any) {
        urgencyPickerView.isHidden = false
        urgencyTypeSelected.isHidden = true
    }
    
    // Importance Button shows the value of Importance picker view value.
    @IBAction func impotanceTypeTouched(_ sender: Any) {
        importancePickerView.isHidden = false
        importanceTypeSelected.isHidden = true
    }
    
    // Category Button shows the value of Category picker view value.
    @IBAction func categoryTypeTouched(_ sender: Any) {
        categoryPickerView.isHidden = false
        categoryTypeSelected.isHidden = true
    }
    
    // Estimates Based On Button shows the value of Estimates Based On picker view value.
    @IBAction func estimatesBasedOnTypeTouched(_ sender: Any) {
        estimatesBasedOnPickerView.isHidden = false
        estimatesBasedOnTypeSelected.isHidden = true
    }
    
    // To dismiss the keyboard
    @IBAction func singleTapGesture(_ sender: UITapGestureRecognizer) {
        self.estimatedCost.resignFirstResponder()
    }

    // View to go up when ever keyboard opens
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.view.frame.origin.y = -150
    }
    
    // when the keyboard is dismissed the view comes to normal position.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.frame.origin.y = 0
     
        textField.resignFirstResponder()
        
        return true
    }
}

//
//  DataEntryViewController.swift
//  TeamBlack
//
//  Created by OSU App Center on 11/10/18.
//  Copyright © 2018 Oklahoma State University. All rights reserved.
//

import UIKit

class DataEntryViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
 
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
    
    var description_expensesResult = ""
    var urgencyTypeResult = String()
    var importanceResult = String()
    var categoryResult = String()
    var estimatedCostResult : Double = 0.0
    var estimateBasisResult = String()
    var noteResult = ""
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

        // Picker view objects delegate and datasource.
        urgencyPickerView.dataSource = self;
        urgencyPickerView.delegate=self;

        importancePickerView.dataSource = self;
        importancePickerView.delegate=self;

        categoryPickerView.dataSource = self;
        categoryPickerView.delegate=self;

        estimatesBasedOnPickerView.dataSource = self;
        estimatesBasedOnPickerView.delegate=self;
        
        note.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        description_expensesResult = description_expenses.text!
        estimatedCostResult = Double(estimatedCost.text!)!
        noteResult = note.text!
        urgencyTypeResult = urgencyTitle
        importanceResult = importanceTitle
        categoryResult = categoryTitle
        estimateBasisResult = estimatesBasedOnTitle
        
        // add the expense to the database 
        let e = Expense(UserVariables.propertyID
            , description_expenses.text!
            , urgencyTypeResult
            , importanceResult
            , categoryResult
            , estimatedCostResult
            , estimateBasisResult
            , noteResult
            , "no" // hidden
            , "no") // completed
        
        DatabaseHelper.addExpense(e, self)
    }
   
    // Number of components in each picker view object.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //  Number of rows in each picker view object.
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
    
    // picker view rows
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            let titleData = urgencyPickerType[row]
            urgencyTitle = titleData
            return urgencyPickerType[row]
        } else if pickerView.tag == 2 {
            let titleData = importancePickerType[row]
            importanceTitle = titleData
            return importancePickerType[row]
        } else if pickerView.tag == 3 {
            let titleData = categoryPickerType[row]
            categoryTitle = titleData
            return categoryPickerType[row]
        } else {
            let titleData = estimatesBasedOnPickerType[row]
            estimatesBasedOnTitle = titleData
            return estimatesBasedOnPickerType[row]
        }
    }
    
    // Picker view value given to button value.
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            let titleData = urgencyPickerType[row]
            urgencyTitle = titleData
            return urgencyPickerType[row]
        } else if pickerView.tag == 2 {
            let titleData = importancePickerType[row]
            importanceTitle = titleData
            return importancePickerType[row]
        } else if pickerView.tag == 3 {
            let titleData = categoryPickerType[row]
            categoryTitle = titleData
            return categoryPickerType[row]
        } else {
            let titleData = estimatesBasedOnPickerType[row]
            estimatesBasedOnTitle = titleData
            return estimatesBasedOnPickerType[row]
        }
    }
    
    // Picker View hidden after selecting value
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView.tag == 1 {
            urgencyTypeSelected.setTitle(urgencyTitle, for: UIControl.State.normal)
            self.urgencyTypeSelected.isHidden = false
            urgencyPickerView.isHidden = true
        } else if pickerView.tag == 2 {
            importanceTypeSelected.setTitle(importanceTitle, for: UIControl.State.normal)
            self.importanceTypeSelected.isHidden = false
            importancePickerView.isHidden = true
        } else if pickerView.tag == 3 {
            categoryTypeSelected.setTitle(categoryTitle, for: UIControl.State.normal)
            self.categoryTypeSelected.isHidden = false
            categoryPickerView.isHidden = true
        } else {
            estimatesBasedOnTypeSelected.setTitle(estimatesBasedOnTitle, for: UIControl.State.normal)
            self.estimatesBasedOnTypeSelected.isHidden = false
            estimatesBasedOnPickerView.isHidden = true
        }
    }
 
    // Update Info to table.
    @IBAction func submitTouched(_ sender: Any) {
        performSegue(withIdentifier: "unwindFromSave", sender: nil)
    }
    
    // Urgency Button hides button and shows up the picker view.
    @IBAction func urgencyTypeTouched(_ sender: Any) {
        urgencyPickerView.isHidden = false
        urgencyTypeSelected.isHidden = true
    }
    
    // Importance Button hides button and shows up the picker view.
    @IBAction func impotanceTypeTouched(_ sender: Any) {
        importancePickerView.isHidden = false
        
        importanceTypeSelected.isHidden = true
    }
   
    // Category Button hides button and shows up the picker view.
    @IBAction func categoryTypeTouched(_ sender: Any) {
        categoryPickerView.isHidden = false
        categoryTypeSelected.isHidden = true
    }
    
    // Estimates Based On Button hides button and shows up the picker view.
    @IBAction func estimatesBasedOnTypeTouched(_ sender: Any) {
        estimatesBasedOnPickerView.isHidden = false
        estimatesBasedOnTypeSelected.isHidden = true
    }
    
    // Single tap gesture to dismiss the keyboard
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
//        estimatedCost.resignFirstResponder()
        textField.resignFirstResponder()
        
        return true
    }
}

//
//  AddItemViewController.swift
//  DueDateTracker
//
//  Created by Chanikya on 9/02/2016.
//  Copyright © 2016 jyothi.demo. All rights reserved.
//

import UIKit
import CoreData

class AddItemViewController: UIViewController, UITextFieldDelegate{
    var categoryValue = "", currentvalue: String = ""
    var values = ["daily", "weekly", "monthly", "yearly", "never"]
    var category = ["Credit Cards", "Groceries", "Auto Loan", "Rent", "Utilities", "Other"]
    var items = [String]()
    
    @IBOutlet weak var itemNameLabel: UITextField!
    
    @IBOutlet weak var categoryLabel: UIPickerView!
    
    @IBOutlet weak var descLabel: UITextField!
    
    @IBOutlet weak var myDatePicker: UIDatePicker!
    
    @IBOutlet weak var myPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Item"
        itemNameLabel.delegate = self
        descLabel.delegate = self
        // self.navigationController?.navigationItem.title = "add item"
        myDatePicker.addTarget(self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    
    func getManagedObjectContext() -> NSManagedObjectContext
    {
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDel.managedObjectContext
    }
    
    
    @IBAction func mySaveButton(sender: AnyObject) {
        
        Alert()
    }
    
    func saveData(){
        let entityDescription = NSEntityDescription.entityForName("Items", inManagedObjectContext: self.getManagedObjectContext())
        let newItem = NSManagedObject(entity: entityDescription!, insertIntoManagedObjectContext: self.getManagedObjectContext())
        
        let textField1 = itemNameLabel.text
        let textField2 = descLabel.text
        let textField3 = myDatePicker.date
        
        newItem.setValue(textField1, forKey: "itemName")
        newItem.setValue(categoryValue, forKey: "category")
        newItem.setValue(textField2, forKey: "desc")
        newItem.setValue(textField3, forKey: "dueDate")
        newItem.setValue(currentvalue, forKey: "rep")
        do{
            try newItem.managedObjectContext?.save()
            print("success")
            
            
        } catch{
            print("failed...............................")
            print(error)
        }
        
    }
    
    @IBAction func Alert()
    {
        let alertController = UIAlertController(title: "Confirmation", message: "Continue adding item ", preferredStyle:UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default)
            { action -> Void in
                self.saveData()
                self.performSegueWithIdentifier("saveSegueId", sender: self)
            })
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default)
            { action -> Void in
                self.performSegueWithIdentifier("CancelSegueId", sender: self)
            })
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        //textField.resignFirstResponder()
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    func dismissKeyboard() {
        itemNameLabel.resignFirstResponder()
        descLabel.resignFirstResponder()
    }
    
    //date picker ....
    func datePickerChanged(myDatePicker:UIDatePicker) {
        dismissKeyboard()
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        //var selectedDate  = dateFormatter.stringFromDate(myDatePicker.date)
    }
    
    //picker view ....
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == myPickerView {
            return values.count }
        else {
            return category.count
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!{
        if pickerView == myPickerView {
            return values[row]
        } else {
            return category[row]
        }
    }
    
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int)
    {
        dismissKeyboard()
        if pickerView == myPickerView {
            currentvalue = values[row]
        } else {
         categoryValue = category[row]
    }
    }
    
}

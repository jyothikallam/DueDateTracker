//
//  ItemDetailViewController.swift
//  DueDateTracker
//
//  Created by Chanikya on 10/03/2016.
//  Copyright © 2016 jyothi.demo. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var myTableView: UITableView!
    var managedObj:NSManagedObject!

    var values: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func getManagedObjectContext() -> NSManagedObjectContext
    {
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDel.managedObjectContext
    }

    @IBAction func saveDetails(sender: AnyObject) {
        let strDate = values[2]
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let finishDate = dateFormatter.dateFromString( strDate )
        
        managedObj.setValue(values[0], forKey: "itemName")
        managedObj.setValue(values[1], forKey: "category")
        managedObj.setValue(finishDate, forKey: "dueDate")
        managedObj.setValue(values[3], forKey: "desc")
        managedObj.setValue(values[4], forKey: "rep")
        do{
            try managedObj.managedObjectContext?.save()
            performSegueWithIdentifier("EditItemIdentifier", sender: self)
            print("success")
        } catch{
            print("failed...............................")
            print(error)
        }
    }
    
    func deleteItem() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        managedContext.deleteObject(managedObj)
        appDelegate.saveContext()

        performSegueWithIdentifier("EditItemIdentifier", sender: self)
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0: let cell = tableView.dequeueReusableCellWithIdentifier("detailCell", forIndexPath: indexPath) as! EditItemDetailTableViewCell
                cell.myTextField?.text = "\(values[indexPath.row])"
                cell.myLabel?.text = "Bill Name:"
                return cell
        case 1: let cell = tableView.dequeueReusableCellWithIdentifier("detailCell", forIndexPath: indexPath) as! EditItemDetailTableViewCell
                cell.myTextField?.text = "\(values[indexPath.row])"
                cell.myLabel?.text = "Category:"
                return cell
        case 2: let cell = tableView.dequeueReusableCellWithIdentifier("detailCell", forIndexPath: indexPath) as! EditItemDetailTableViewCell
                cell.myTextField?.text = "\(values[indexPath.row])"
                cell.myLabel?.text = "Due Date:"
                return cell
        case 3: let cell = tableView.dequeueReusableCellWithIdentifier("detailCell", forIndexPath: indexPath) as! EditItemDetailTableViewCell
                cell.myTextField?.text = "\(values[indexPath.row])"
                cell.myLabel?.text = "Description:"
                return cell
        case 4: let cell = tableView.dequeueReusableCellWithIdentifier("detailCell", forIndexPath: indexPath) as! EditItemDetailTableViewCell
                cell.myTextField?.text = "\(values[indexPath.row])"
                cell.myLabel?.text = "Repeat:"
                return cell
            
       case 5:  let cell1 = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! DeleteItemTableViewCell
                cell1.delegate = self
                return cell1
                //cell.myTextField!.font = UIFont(name: "Helvetica-Bold", size: 18.0)
                // cell.myTextField!.textColor = UIColor.redColor()

        default:let cell1 = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath)
                return cell1
        }
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row == 5){
            deleteItem()
        }
    }
    
}

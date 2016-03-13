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
        if section == 0 {
            return 5
        }
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
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

            default:let cell = tableView.dequeueReusableCellWithIdentifier("detailCell", forIndexPath: indexPath) as! EditItemDetailTableViewCell
                    return cell
            }
        }
        else {
            let cell1 = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! DeleteItemTableViewCell
            cell1.delegate = self
            return cell1
            //cell.myTextField!.font = UIFont(name: "Helvetica-Bold", size: 18.0)
            // cell.myTextField!.textColor = UIColor.redColor()
        }
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row == 5){
            deleteItem()
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hView = UIView(frame: CGRectMake(0, 0, self.myTableView.frame.size.width, 30))
        return hView
    }
    
//    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let fView = UIView(frame: CGRectMake(0, 0, self.myTableView.frame.size.width, 30))
//        return fView
//    }
    
}
